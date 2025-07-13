# Traffic Light Controller (Verilog)

A finite state machine (FSM) implementation of a traffic light controller with timed state transitions and enable control.

## Features

- 🚦 Three-phase traffic light control (Red-Yellow-Green)
- ⏱️ Configurable timing for each state:
  - Red light: 4 clock cycles
  - Yellow light: 2 clock cycles
  - Green light: 6 clock cycles
- 🔘 Enable signal (`din`) for controlled state transitions
- 🔄 Automatic state sequence with proper timing
- 🔧 Synchronous active-high reset
