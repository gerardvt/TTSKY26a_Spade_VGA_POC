![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# TTSKY26a Spade VGA PoC

A [Tiny Tapeout](https://tinytapeout.com) project targeting the `ttsky26a` shuttle (Sky130A PDK), authored in [Spade HDL](https://spade-lang.org) — a Rust-inspired hardware description language that compiles to SystemVerilog.

- [Project datasheet](docs/info.md)

---

## Purpose

This project is a **proof of concept for using Spade HDL as a Tiny Tapeout design entry language**, not a showcase of a sophisticated hardware design. The goal is to work through all the scaffolding required to take a Spade-based design through the full TT submission pipeline end-to-end:

- Setting up a Spade project with the `swim` build tool and wiring its output into the TT source file layout
- Using a permanent Verilog shim (`tt_um_gvt.v`) to bridge the fixed TT port interface to the Spade-generated core
- Configuring CI workflows (`test`, `docs`, `gds`) to build Spade on every push with effective binary caching
- Resolving integration issues with the TT VGA Playground (see below)

The design — an interactive XOR plasma effect — is intentionally simple. It was chosen as a convenient vehicle for exercising the full submission workflow, including all eight input pins, rather than as an end in itself. The infrastructure and lessons documented here provide a reusable foundation for future, more ambitious Spade-based TT entries.

---

## Design: interactive XOR plasma effect

The design generates a full-screen animated plasma on VGA 640×480 @ 60 Hz. Each active pixel is coloured by XOR-combining the lower bits of the screen coordinates with an 8-bit frame counter, producing a richly patterned animated colour effect. Four pattern variants, four animation speeds, colour inversion, and four colour-channel rotation modes are all controllable in real time via `ui_in`.

All eight input pins are active. The controls are **independent bit fields** — multiple pins may be high simultaneously and each takes effect concurrently.

```
  bit:  7   6   5   4   3   2   1   0
        | rot  |inv|  speed  |pattern|pause
         [7:6]  [5] [4:3]   [2:1]    [0]
```

| `ui_in` | Field | Values |
|---|---|---|
| `[0]` | **pause** | 1 = freeze animation, 0 = run |
| `[2:1]` | **pattern** | `00` = grid (`hx^vy`, default) · `01` = diagonal (`hx+vy`) · `10` = interference (`hx^(hx+vy)`) · `11` = plasma (`hx^vy^(hx+vy)`) |
| `[4:3]` | **speed** | Frame counter step: `00`=×1 · `01`=×2 · `10`=×4 · `11`=×8 |
| `[5]` | **invert** | 1 = complement all colour bits |
| `[7:6]` | **rot** | Rotate R/G/B channel assignment through four 2-bit pairs of the plasma value |

**Example values:**

| `ui_in` | Effect |
|---|---|
| `0x00` | Default: grid XOR pattern, speed ×1, standard colours |
| `0x01` | Frozen at current frame |
| `0x06` | Diagonal pattern (`[2:1] = 01`) |
| `0x18` | Speed ×4 (`[4:3] = 10`) |
| `0x20` | Inverted colours |
| `0x40` | Colour rotation mode 1 (`[7:6] = 01`) |
| `0xFF` | All controls active: plasma pattern, speed ×8, inverted, rotation 3, frozen |

Pause freezes the frame counter regardless of speed — pattern, invert, and colour rotation still render at the frozen frame.

---

## VGA Playground integration

Tiny Tapeout creates a project page for each registered design (e.g. `app.tinytapeout.com/projects/NNNN`). That page includes a **VGA Playground: Open** link which opens a simulation at a URL of the form:

```
https://vga-playground.com/?repo=https://github.com/[owner]/[repo]&ref=[commit-sha]
```

The `ref` is the exact commit SHA that TT captured when "Submit a new revision" was last clicked on the project page. The playground then:

1. Fetches `info.yaml` from the repo at that specific commit
2. Reads the `source_files` list
3. Fetches each listed file from `src/` at the same commit SHA via the GitHub raw content API

**The problem — generated SystemVerilog is not committed**

The SystemVerilog that feeds the playground (`design.v`) is produced by `swim build` and was initially gitignored. Standard practice is to not commit CI-generated build artefacts — they are always regenerated from the Spade source on each build. This means `design.v` does not exist in the repo at any commit SHA, and the playground gets a 404 when it tries to fetch it.

This is a chicken-and-egg situation: the playground needs the compiled output to simulate the design, but the correct practice for generated files is to not commit them.

**The compromise**

In this submission repo, `src/design.v` is **removed from `.gitignore` and committed** alongside the Spade source. The CI still regenerates it on every workflow run (overwriting the committed copy), so it always reflects the current source. When "Submit a new revision" is clicked on the TT project page, TT captures the HEAD SHA at that point — a commit that includes `design.v` — and the playground can fetch it successfully.

The trade-off is that `design.v` appears as a tracked file even though it is a build artefact. This is a deliberate compromise, made only in the submission repo. The development repo (`ttsky26a-gvt-design`) keeps generated files gitignored as normal practice.

---

## Design language: Spade HDL

Spade offers a Rust-like type system, strong type inference, and built-in support for common hardware patterns. It catches a class of bugs at compile time that Verilog defers to simulation or silicon. It compiles to SystemVerilog via its build tool [swim](https://gitlab.com/spade-lang/swim), and the generated SystemVerilog feeds the standard TT flow (OpenLane synthesis, cocotb simulation, docs check) unchanged.

### How the build works

```
spade/src/main.spade   →   swim build   →   spade/build/spade.sv
                                                      │
                                                      └── cp ──► src/design.v
```

`src/design.v` is generated on every CI run. The permanent committed file is `src/tt_um_gvt.v` — a thin Verilog shim that exposes the fixed TT port interface and instantiates the Spade-generated core.

To build locally:

```bash
cd spade
swim build
cp build/spade.sv ../src/design.v
```

---

## Project structure

```
spade/
  swim.toml          # Spade project manifest (package name = gvt_design)
  swim.lock          # Pins the Spade compiler commit for reproducibility
  src/
    main.spade       # Design source — edit this to change the design
  build/
    spade.sv         # Generated SystemVerilog (gitignored)

src/
  tt_um_gvt.v        # Permanent TT shim — committed, never modified
  design.v           # Generated by swim build — committed for VGA Playground

test/
  tb.v               # Cocotb testbench
  test.py            # Test logic
  Makefile           # Runs iverilog + cocotb

.github/workflows/
  docs.yaml          # Validates info.yaml + docs/info.md
  test.yaml          # RTL simulation via cocotb
  gds.yaml           # Full OpenLane GDS build
  fpga.yaml          # FPGA flow
```

---

## Shim + generated core architecture

The design uses a two-file split:

| File | Origin | Committed | Purpose |
|---|---|---|---|
| `src/tt_um_gvt.v` | Hand-written once | Yes | TT-facing shim: defines `tt_um_gerardvt_spade_poc`, instantiates `gvt_core` |
| `src/design.v` | Generated by `swim build` | Yes (for playground) | Actual design logic compiled from Spade |

### Spade port interface

Spade's `#[no_mangle(all)]` attribute is applied to the `gvt_core` entity. This does two things:

1. Suppresses the package namespace prefix — without it the module would be generated as `\gvt_design::gvt_core` (an escaped SystemVerilog identifier), making the shim awkward to write.
2. Suppresses the `_i`/`_o` suffixes Spade normally appends to port names.

Outputs are declared as `inv` ports in the parameter list and driven with `set port = value` inside the entity body. The result is a generated module with plain port names that match the TT interface directly — no unpacking or name mapping needed in the shim.

---

## CI workflows

All three workflows install Rust and swim before doing anything else, then regenerate `src/design.v` from Spade before any lint, synthesis, or simulation step runs.

### Swim binary caching

`cargo install --git ...` rebuilds swim from source and takes ~1m45s. All three workflows cache the compiled binary using `actions/cache`, keyed on the hash of `swim.toml`. After the first run the install step is skipped and swim is available instantly.

### Why all three workflows run swim build

The TT docs workflow verifies that every file listed in `info.yaml source_files` exists on disk. Even though `design.v` is now committed, the docs workflow still runs `swim build` to ensure the committed file is always in sync with the Spade source.

---

## Running tests locally

Install dependencies once:

```bash
# Spade build tool
cargo install --git https://gitlab.com/spade-lang/swim

# Icarus Verilog (simulation backend)
# macOS with oss-cad-suite: already included
# Ubuntu: sudo apt-get install -y iverilog

# Python test dependencies
pip install -r test/requirements.txt
```

Build and test (run from the project root):

```bash
cd spade && swim build && cp build/spade.sv ../src/design.v && cd ..
cd test && make clean && make
```

Test results are written to `test/results.xml`. Waveforms are dumped to `test/tb.fst` (viewable with GTKWave or Surfer).

> **Note:** The above covers RTL simulation only. Running the docs validation and GDS build locally requires further integration with the tooling provided by [TinyTapeout/tt-support-tools](https://github.com/TinyTapeout/tt-support-tools). This has not yet been tested and is deferred for a future update.
