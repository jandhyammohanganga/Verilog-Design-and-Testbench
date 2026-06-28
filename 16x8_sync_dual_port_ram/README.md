
# 16×8 Synchronous Dual Port RAM

A simple synchronous dual-port RAM implemented in Verilog HDL — 16 memory locations, each 8 bits wide, with independent read and write ports driven by a single clock.

---

## 📁 Files

| File | Description |
|------|-------------|
| `dual_sync_16x8.v` | RTL design (module `mem`) |
| `dual_sync_16x8_tb.v` | Testbench (module `mem_tb`) |

---

## 🔌 Port Description

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| `clk` | Input | 1 | Clock (positive edge triggered) |
| `rst` | Input | 1 | Synchronous reset — clears all memory |
| `we` | Input | 1 | Write enable |
| `re` | Input | 1 | Read enable |
| `w_add` | Input | 4 | Write address (0–15) |
| `r_add` | Input | 4 | Read address (0–15) |
| `w_data` | Input | 8 | Data to write |
| `r_data` | Output | 8 | Data read out |

---

## ⚙️ How It Works

All operations are triggered on the **positive edge of `clk`**:

- **Reset** (`rst = 1`) — clears all 16 locations and sets `r_data` to 0
- **Write** (`we = 1, re = 0`) — stores `w_data` into `mem[w_add]`
- **Read** (`re = 1, we = 0`) — outputs `mem[r_add]` on `r_data`

> Write and read cannot happen simultaneously — only one operation is active at a time.

---

## 🧪 Testbench Summary

The testbench (`mem_tb`) uses reusable tasks:

| Task | Action |
|------|--------|
| `initialize` | Resets all inputs to 0 |
| `write` | Asserts `we`, deasserts `re` |
| `read` | Asserts `re`, deasserts `we` |
| `stimulus(i)` | Sets `w_add`, `r_add`, `w_data` all to `i` |

**Test flow:**
1. Initialize all signals
2. Write values `0–15` into addresses `0–15`
3. Read back values from addresses `0–15`
4. End simulation

---

## 🚀 How to Simulate

**QuestaSim**
```tcl
vlog dual_sync_16x8.v dual_sync_16x8_tb.v
vsim mem_tb
run -all
```

**VCS**
```bash
vcs dual_sync_16x8.v dual_sync_16x8_tb.v -o simv && ./simv
```

**Icarus Verilog**
```bash
iverilog -o sim.out dual_sync_16x8.v dual_sync_16x8_tb.v && vvp sim.out
```

---

## 👤 Author

**Mohan Jandhyam** — VLSI Design & Verification Engineer  
[![GitHub](https://img.shields.io/badge/GitHub-jandhyammohanganga-181717?logo=github)](https://github.com/jandhyammohanganga)
