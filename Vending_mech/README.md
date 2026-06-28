
# Vending Machine — FSM Design in Verilog

A coin-based vending machine implemented as a **Finite State Machine (FSM)** in Verilog HDL. The machine accepts 5-rupee (`i`) and 10-rupee (`j`) coins and dispenses an item worth 15 rupees, with change returned if overpaid.

---

## 📁 Files

| File | Description |
|------|-------------|
| `vending_mech.v` | RTL design (module `VendingMachine`) |
| `vending_mech_tb.v` | Testbench (module `VendingMachine_tb`) |

---

## 🔌 Port Description

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| `clk` | Input | 1 | Clock (positive edge triggered) |
| `rst` | Input | 1 | Synchronous reset — returns to idle state |
| `i` | Input | 1 | Insert 5-rupee coin |
| `j` | Input | 1 | Insert 10-rupee coin |
| `X` | Output | 1 | Dispense item |
| `Y` | Output | 1 | Return change |

---

## ⚙️ FSM Description

The machine has **5 states** tracking the total coins inserted:

| State | Meaning          | Total Inserted |
|-------|-----------------|----------------|
| `RST` | Idle / Reset    | ₹0             |
| `Rs1` | ₹5 inserted     | ₹5             |
| `Rs2` | ₹10 inserted    | ₹10            |
| `Rs3` | ₹15 reached     | ₹15 — dispense |
| `Rs4` | ₹20 inserted    | ₹20 — dispense + change |

### Coin Input Encoding

| `{i, j}` | Coin Inserted |
|----------|--------------|
| `2'b10`  | ₹5 coin      |
| `2'b11`  | ₹10 coin     |
| `2'b0x`  | No coin      |

### Output Logic

| State | `X` (Dispense) | `Y` (Change) |
|-------|----------------|--------------|
| `Rs3` | 1              | 0            | Item dispensed, no change |
| `Rs4` | 1              | 1            | Item dispensed + change returned |
| Others | 0             | 0            | Waiting for more coins |

---

## 🔄 State Transition Diagram

```
         ₹5(10)        ₹5(10)        ₹5(10)
  ┌──────────►Rs1──────────►Rs2──────────►Rs3──► RST (X=1)
  │                    │                  │
RST          ₹10(11)   │     ₹10(11)     │
  │         ┌──────────┘    ┌────────────┘
  │         ▼               ▼
  │        Rs2             Rs4──► RST (X=1, Y=1)
  │
  └── no coin (0x) ──► RST
```

---

## 🧪 Testbench Summary

The testbench (`VendingMachine_tb`) uses three tasks and dumps a VCD waveform file.

| Task | Action |
|------|--------|
| `initialize` | Resets all inputs; asserts `rst` |
| `stimulus(I, J)` | Applies coin inputs `i=I`, `j=J` on negative clock edge |
| `monitor` | Dumps waveform to `VendingMachine_tb.vcd` |

**Test sequence applied:**

| Step | `i` | `j` | Coins |
|------|-----|-----|-------|
| 1 | 0 | 0 | No coin |
| 2 | 0 | 1 | ₹10 |
| 3 | 1 | 1 | ₹10 |
| 4 | 1 | 0 | ₹5 |
| 5 | 1 | 1 | ₹10 |

---

## 🚀 How to Simulate

**QuestaSim**
```tcl
vlog vending_mech.v vending_mech_tb.v
vsim VendingMachine_tb
run -all
```

**VCS**
```bash
vcs vending_mech.v vending_mech_tb.v -o simv && ./simv
```

**Icarus Verilog**
```bash
iverilog -o sim.out vending_mech.v vending_mech_tb.v && vvp sim.out
```

> A VCD waveform file `VendingMachine_tb.vcd` is generated automatically — open it in GTKWave to view signal transitions.

---

## 👤 Author

**Mohan Jandhyam** — VLSI Design & Verification Engineer  
[![GitHub](https://img.shields.io/badge/GitHub-jandhyammohanganga-181717?logo=github)](https://github.com/jandhyammohanganga)
