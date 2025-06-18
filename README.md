# 🧠 8-Bit ALU in Verilog

This project is a Verilog-based implementation of an **8-bit Arithmetic Logic Unit (ALU)**. It performs a variety of arithmetic and logical operations based on the input control signal (`opcode`). The design is structured for simulation and synthesis on Xilinx FPGAs.

---

## ⚙️ Features

- **Inputs:**
  - `A` (8-bit)
  - `B` (8-bit)
  - `opcode` (4-bit control signal)

- **Outputs:**
  - `Y` (16-bit result)
  - `carry_out`, `overflow` (optional status flags)

- **Supported Operations:**

| Opcode | Operation       |
|--------|------------------|
| 0000   | Addition          |
| 0001   | Subtraction       |
| 0010   | AND               |
| 0011   | OR                |
| 0100   | XOR               |
| 0101   | Left Shift        |
| 0110   | Right Shift       |
| 0111   | Equal Comparison  |
| 1000   | Addition          |
| 1001   | Subtraction       |
| 1010   | AND               |
| 1011   | OR                |
| 1100   | XOR               |
| 1101   | Left Shift        |
| 1110   | Right Shift       |
| 1111   | Equal Comparison  |
---

## 📁 File Structure

| File Name           | Description                          |
|---------------------|--------------------------------------|
| `alu.v`             | Main Verilog ALU module              |
| `alu_tb.v`          | Testbench with all operation cases   |
| `README.md`         | Project documentation (this file)    |
| `alu_schematic.pdf` | Schematic diagram of ALU (optional)  |
| `alu_waveform.pdf`  | Waveform simulation results          |

---

## 🛠️ Tools Used

- **HDL:** Verilog
- **Simulation:** ModelSim / Vivado Simulator
- **Synthesis:** Xilinx Vivado
- **Target FPGA:** XC7A50TCSG324-1 (Artix-7)

---

## 🧪 How to Simulate

1. Open `alu.v` and `alu_tb.v` in your simulator
2. Run the simulation
3. Observe output for each opcode scenario

---


## 👨‍💻 Author

- **P Chakradhar**
- B.Tech Final Year – Aspiring RTL Design & Verification Engineer
- [GitHub Profile](https://github.com/chakri2205)
- [Gmail id](chakradhar2205@gmail.com)

