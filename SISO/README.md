
# 4-bit SISO Right Shift Register

A 4-bit Serial-In Serial-Out (SISO) right shift register implemented in Verilog HDL. Data is shifted in one bit at a time and appears at the output after 4 clock cycles.

---

## 📁 Files

| File | Description |
|------|-------------|
| `siso.v` | RTL design (module `siso`) |
| `siso_tb.v` | Testbench (module `SISO4bit_tb`) |

---

## 🔌 Port Description

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| `clk` | Input | 1 | Clock (positive edge triggered) |
| `rst` | Input | 1 | Synchronous reset — clears all stages |
| `in` | Input | 1 | Serial data input |
| `y` | Output | 1 | Serial data output |

---

## ⚙️ How It Works

On every **positive edge of `clk`**:

- **Reset** (`rst = 1`) — clears all internal stages and output `y` to 0
- **Shift** (`rst = 0`) — data moves right through 4 stages: `in → w[0] → w[1] → w[2] → y`

Each bit takes **4 clock cycles** to travel from input to output.

```
in → [w[0]] → [w[1]] → [w[2]] → y
       Stage 1   Stage 2   Stage 3   Stage 4
```

---

## 🧪 Testbench Summary

The testbench (`SISO4bit_tb`) applies the serial input sequence **`0, 1, 1, 0`** and observes the output after 4 shifts.

| Task | Action |
|------|--------|
| `initialize` | Sets `clk`, `i` to 0; asserts `rst` |
| `in(j)` | Applies bit `j` on the negative clock edge |

**Test flow:**
1. Initialize and hold reset
2. Release reset on negative clock edge
3. Shift in bits: `0 → 1 → 1 → 0`
4. Wait 50 ns and end simulation

---

## 🚀 How to Simulate

**QuestaSim**
```tcl
vlog siso.v siso_tb.v
vsim SISO4bit_tb
run -all
```

**VCS**
```bash
vcs siso.v siso_tb.v -o simv && ./simv
```

**Icarus Verilog**
```bash
iverilog -o sim.out siso.v siso_tb.v && vvp sim.out
```

---

## 👤 Author

**Mohan Jandhyam** — VLSI Design & Verification Engineer  
[![GitHub](https://img.shields.io/badge/GitHub-jandhyammohanganga-181717?logo=github)](https://github.com/jandhyammohanganga)
