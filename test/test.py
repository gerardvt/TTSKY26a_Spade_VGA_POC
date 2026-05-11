# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, FallingEdge

# VGA timing constants (640x480 @ 60Hz)
H_ACTIVE     = 640
H_FP         = 16
H_SYNC_W     = 96
H_BP         = 48
H_TOTAL      = H_ACTIVE + H_FP + H_SYNC_W + H_BP  # 800

H_SYNC_START = H_ACTIVE + H_FP          # 656 — HSYNC goes low (active low)
H_SYNC_END   = H_SYNC_START + H_SYNC_W  # 752 — HSYNC returns high

V_ACTIVE     = 480
V_FP         = 10
V_SYNC_W     = 2
V_SYNC_END   = V_ACTIVE + V_FP + V_SYNC_W  # 492

HSYNC_BIT = 7   # uo_out[7]
VSYNC_BIT = 3   # uo_out[3]


def get_hsync(dut):
    return (int(dut.uo_out.value) >> HSYNC_BIT) & 1

def get_vsync(dut):
    return (int(dut.uo_out.value) >> VSYNC_BIT) & 1


async def reset_dut(dut):
    clock = Clock(dut.clk, 40, unit="ns")  # 25 MHz
    cocotb.start_soon(clock.start())
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1


async def sample(dut):
    """Sample outputs mid-cycle (falling edge) when registers are settled."""
    await FallingEdge(dut.clk)


@cocotb.test()
async def test_hsync_active(dut):
    """HSYNC should be low during the sync pulse."""
    await reset_dut(dut)
    # Advance well into the sync pulse (H_SYNC_START + half of H_SYNC_W cycles in)
    await ClockCycles(dut.clk, H_SYNC_START + H_SYNC_W // 2)
    await sample(dut)
    assert get_hsync(dut) == 0, f"HSYNC should be low mid-sync, got {get_hsync(dut)}"
    dut._log.info("HSYNC low during sync pulse: OK")


@cocotb.test()
async def test_hsync_inactive(dut):
    """HSYNC should be high during the active and back-porch regions."""
    await reset_dut(dut)
    # Sample well within the active region (quarter-way through)
    await ClockCycles(dut.clk, H_ACTIVE // 4)
    await sample(dut)
    assert get_hsync(dut) == 1, f"HSYNC should be high in active region, got {get_hsync(dut)}"
    dut._log.info("HSYNC high during active region: OK")


@cocotb.test()
async def test_vsync_inactive_first_frame(dut):
    """VSYNC should be high (inactive) during the active area of the first frame."""
    await reset_dut(dut)
    # Sample mid-way through the active area (line 240)
    await ClockCycles(dut.clk, H_TOTAL * (V_ACTIVE // 2))
    await sample(dut)
    assert get_vsync(dut) == 1, f"VSYNC should be high in active area, got {get_vsync(dut)}"
    dut._log.info("VSYNC high during active area: OK")
