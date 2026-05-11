# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, FallingEdge

# VGA timing constants (640x480 @ 60Hz)
H_TOTAL      = 800
V_TOTAL      = 525
H_SYNC_START = 656
H_SYNC_END   = 752
V_SYNC_START = 490
V_SYNC_END   = 492

HSYNC_BIT = 7   # uo_out[7]
VSYNC_BIT = 3   # uo_out[3]


def get_hsync(dut):
    return (int(dut.uo_out.value) >> HSYNC_BIT) & 1

def get_vsync(dut):
    return (int(dut.uo_out.value) >> VSYNC_BIT) & 1

def get_rgb(dut):
    """Return (r, g, b) using the R0/G0/B0 bits (bits 4, 5, 6 of uo_out)."""
    v = int(dut.uo_out.value)
    return ((v >> 4) & 1, (v >> 5) & 1, (v >> 6) & 1)

def get_rgb_full(dut):
    """Return (r, g, b) as 2-bit values: MSB from bits 4/5/6, LSB from bits 0/1/2."""
    v = int(dut.uo_out.value)
    r = (((v >> 4) & 1) << 1) | ((v >> 0) & 1)
    g = (((v >> 5) & 1) << 1) | ((v >> 1) & 1)
    b = (((v >> 6) & 1) << 1) | ((v >> 2) & 1)
    return (r, g, b)

def xor_pixel(hc, vc, frame=0):
    """Compute animated XOR value: (hc[7:0] XOR vc[7:0]) XOR frame_ctr."""
    return ((hc & 0xFF) ^ (vc & 0xFF) ^ (frame & 0xFF))


async def reset_dut(dut, ui_in=0x00):
    clock = Clock(dut.clk, 40, unit="ns")  # 25 MHz
    cocotb.start_soon(clock.start())
    dut.ena.value    = 1
    dut.ui_in.value  = ui_in
    dut.uio_in.value = 0
    dut.rst_n.value  = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1


async def advance_to_pixel(dut, hc, vc):
    """Advance to the falling edge when hcount==hc, vcount==vc and sample."""
    await ClockCycles(dut.clk, vc * H_TOTAL + hc)
    await FallingEdge(dut.clk)


# ---------------------------------------------------------------------------
# VGA sync tests
# ---------------------------------------------------------------------------

@cocotb.test()
async def test_hsync_active(dut):
    """HSYNC is low during the sync pulse."""
    await reset_dut(dut)
    await ClockCycles(dut.clk, H_SYNC_START + (H_SYNC_END - H_SYNC_START) // 2)
    await FallingEdge(dut.clk)
    assert get_hsync(dut) == 0, f"HSYNC should be low mid-sync, got {get_hsync(dut)}"
    dut._log.info("HSYNC low during sync pulse: OK")


@cocotb.test()
async def test_hsync_inactive(dut):
    """HSYNC is high during the active region."""
    await reset_dut(dut)
    await ClockCycles(dut.clk, 160)
    await FallingEdge(dut.clk)
    assert get_hsync(dut) == 1, f"HSYNC should be high in active region, got {get_hsync(dut)}"
    dut._log.info("HSYNC high during active region: OK")


@cocotb.test()
async def test_vsync_inactive_first_frame(dut):
    """VSYNC is high during the active area of the first frame."""
    await reset_dut(dut)
    await advance_to_pixel(dut, 320, 240)
    assert get_vsync(dut) == 1, f"VSYNC should be high in active area, got {get_vsync(dut)}"
    dut._log.info("VSYNC high during active area: OK")


# ---------------------------------------------------------------------------
# XOR plasma pixel value tests
# ---------------------------------------------------------------------------

@cocotb.test()
async def test_pixel_xor_zero(dut):
    """Pixel (0, 0): XOR value = 0 → all colour bits zero → black."""
    await reset_dut(dut)
    await advance_to_pixel(dut, 0, 0)
    assert xor_pixel(0, 0) == 0
    rgb = get_rgb(dut)
    assert rgb == (0, 0, 0), f"Pixel (0,0) should be black, got {rgb}"
    dut._log.info("Pixel (0,0) black (XOR=0): OK")


@cocotb.test()
async def test_pixel_xor_allones(dut):
    """Pixel (255, 0): XOR = 255 = 0b11111111 → all channel bits set → white."""
    await reset_dut(dut)
    await advance_to_pixel(dut, 255, 0)
    assert xor_pixel(255, 0) == 255
    rgb = get_rgb(dut)
    assert rgb == (1, 1, 1), f"Pixel (255,0) should be white (1,1,1), got {rgb}"
    dut._log.info("Pixel (255,0) white (XOR=255): OK")


@cocotb.test()
async def test_pixel_xor_red(dut):
    """Pixel (128, 0): XOR = 128 = 0b10000000 → only r0 (bit 7) set → get_rgb = (1,0,0)."""
    await reset_dut(dut)
    await advance_to_pixel(dut, 128, 0)
    assert xor_pixel(128, 0) == 128
    rgb = get_rgb(dut)
    assert rgb == (1, 0, 0), f"Pixel (128,0) should be red (1,0,0), got {rgb}"
    dut._log.info("Pixel (128,0) red MSB only (XOR=128): OK")


@cocotb.test()
async def test_pixel_xor_mixed(dut):
    """Pixel (200, 100): XOR = 172 = 0b10101100 → R=2, G=2, B=3."""
    await reset_dut(dut)
    await advance_to_pixel(dut, 200, 100)
    animated = xor_pixel(200, 100)  # 0b11001000 ^ 0b01100100 = 0b10101100 = 172
    assert animated == 172, f"Expected animated=172, got {animated}"
    rgb = get_rgb_full(dut)
    assert rgb == (2, 2, 3), f"Pixel (200,100) should be (2,2,3), got {rgb}"
    dut._log.info("Pixel (200,100) mixed colour (XOR=172): OK")


@cocotb.test()
async def test_display_off_black(dut):
    """Pixel in hblank region (hcount=660) has black RGB (display_on=false)."""
    await reset_dut(dut)
    await advance_to_pixel(dut, 660, 0)
    rgb = get_rgb(dut)
    assert rgb == (0, 0, 0), f"Hblank pixel should be black, got {rgb}"
    dut._log.info("Hblank RGB=0 (display_on=false): OK")
