# VT52 Terminal Core for MiSTer

by Fred Van Eijk

## Overview

This core implements a VT52-compatible terminal emulator for the MiSTer FPGA platform. It provides a terminal interface with keyboard input and UART communication capabilities.

## Features

- 80x24 character display
- Basic VT52 control sequences
- Hardware scrolling buffer (25 rows total)
- PS/2 keyboard interface
- UART communication (115200 baud, 8N1)
- Configurable text color (White, Red, Green, Blue)
- Multiple aspect ratio options

## Setup

### UART Connection - User I/O port

The UART interface is available through the User I/O port on the MiSTer:

- User port pin 1 (D-/TX): Connect to RX of your USB-to-Serial adapter
- User port pin 0 (D+/RX): Connect to TX of your USB-to-Serial adapter
- User port GND: Connect to GND of your USB-to-Serial adapter

Most USB-to-Serial adapters should work. Tested adapters include:

- FTDI FT232RL
- CH340
- CP2102

Note: Make sure your adapter supports 115200 baud and is configured for 8N1 operation.

USB/Serial cable: For more information see the Serial Port section of the Altair8800_MiSTer repository:  <https://github.com/MiSTer-devel/Altair8800_MiSTer>

### For UART/Serial with PuTTY

- Connect at 115200 baud, 8 bits, no parity to the COM port.  Note this uses is the console port on the DE10-Nano

### For SSH with PuTTY

- Connect to the ip address of your MiSTer fpga.

#### Linux command line to establish the connection to the core

1. Identify the UART device:
   - Usually mapped to `/dev/ttyS1` or `/dev/ttyUSB0`
   - Use this command to help identify the correct device:

     ``` bash
     dmesg | grep tty
     ```

2. Access the serial terminal:
   - Use `screen` or `minicom`
   - Example command with `screen`:

     ``` bash
     screen /dev/ttyS1 115200
     ```

   - Replace `/dev/ttyS1` with the correct device identifier
   - Change 115200 to the appropriate baud rate if different

### OSD Menu Options

Access the On-Screen Display (OSD) menu using the Menu button on your MiSTer setup.

Available options:

1. Aspect Ratio
   - Original (4:3) (default)
   - Full Screen

2. Text Color
   - White (default)
   - Red
   - Green
   - Blue

3. UART Selection
   - User IO port (default)
   - Console Port

4. Font Selection
   - Terminus 8x16 (default)
   - VT52 rom 8x8

### Reset Options

- Soft Reset: Available through OSD menu
- Hard Reset: Use the MiSTer reset button or OSD reset option

## Terminal Commands

### Control Characters

- `Ctrl+H` or `Backspace`: Move cursor left
- `Tab`: Move to next tab stop (every 8 columns)
- `LF` (Line Feed): Move cursor down one line
- `CR` (Carriage Return): Move cursor to start of current line

### Implemented VT52 Escape Sequences

All escape sequences start with the ESC character (0x1B):

- `ESC A`: Cursor up
- `ESC B`: Cursor down
- `ESC C`: Cursor right
- `ESC D`: Cursor left
- `ESC H`: Cursor home (upper left corner)
- `ESC I`: Reverse line feed
- `ESC J`: Erase screen from cursor and home cursor
- `ESC K`: Erase to end of current line
- `ESC Y row col`: Direct cursor addressing
  - Row and column are sent as ASCII codes: space (0x20) + row/column number
  - Example: To move to row 5, column 10: `ESC Y % *` (% = 0x20 + 5, * = 0x20 + 10)

### Display Characteristics

- Character Set: Standard ASCII (32-126)
- Cursor: Blinking block cursor
- Hardware scrolling using 25-row buffer (24 visible + 1 scroll buffer)
- Duplicate original video timing with VT52 font

## Test Server

A Python test server script (`vt52-test-server.py`) is included to verify terminal functionality. The server supports both serial and telnet connections.

### Requirements

```bash
pip install pyserial
```

### Usage

Serial mode (default):

```bash
python vt52-test-server.py --port COM9 --baudrate 115200
```

Telnet mode:

```bash
python vt52-test-server.py --mode telnet --port 2323
```

### Test Suite Components

The server tests the following implemented features:

1. Control Characters
   - Backspace behavior
   - Line Feed/Carriage Return
   - Tab spacing (8-column stops)

2. Cursor Positioning
   - Absolute positioning using ESC Y sequences
   - Relative movement (up, down, left, right)
   - Pattern drawing demonstration

3. Erase Functions
   - Erase to end of line (ESC K)
   - Erase screen (ESC J)
   - Cursor positioning after erase

4. Scroll Behavior
   - Forward scrolling using hardware scroll buffer
   - Reverse scrolling with ESC I
   - Line wrapping at screen boundaries

5. Box Drawing Demo
   - Demonstrates cursor movement with visual pattern
   - Tests cursor positioning accuracy

Note: The test suite includes proper timing delays to account for hardware scrolling operations.

## Guess the Animal Game

A sample game application is included (`vt52-guess-the-animal-game.py`) that demonstrates interactive terminal usage. The game implements a word-guessing game similar to Hangman, specifically themed around animals.

### Game Features

- Visual ASCII art display of game progress
- 15 different animals to guess
- 6 attempts allowed per round
- Hardware-synchronized screen updates
- Proper handling of terminal scroll operations
- Support for both serial and telnet connections

### Game Display Layout

``` svg
     +---+
     |   |    Title and game status at top
     O   |    
    /|\  |    Word display in center
    / \  |    
         |    Input prompts at bottom
   =========
```

### Usage

Serial mode (default):

```bash
python vt52-guess-the-animal-game.py --mode serial --port COM9 --baudrate 115200
```

Telnet mode:

```bash
python vt52-guess-the-animal-game.py --mode telnet --port 2323
```

### Command Line Options

``` bash
--mode     : Connection mode (serial or telnet)
--port     : Serial port or telnet port number
--baudrate : Serial baudrate (default: 115200)
--host     : Telnet server host (default: 0.0.0.0)
```

### VT52 Features Used

- `ESC H`: Clear screen and home cursor
- `ESC J`: Erase screen
- `ESC Y`: Direct cursor addressing for UI elements
- Character output with proper timing
- Hardware scroll consideration

### Technical Implementation

- Synchronous screen updates accounting for VT52 timing
- Proper handling of hardware scroll operations
- Clean connection handling for both serial and telnet modes
- Error detection and graceful disconnection handling
- Configurable timing delays for hardware operations

### Connection Handling

- Supports multiple simultaneous telnet clients
- Automatic connection cleanup on client disconnect
- Proper serial port release on program exit
- Error handling for connection loss during gameplay

### Requirements

```bash
pip install pyserial
```

The game serves as both a practical example of terminal usage and a test tool for various VT52 features including cursor positioning, screen clearing, and character I/O timing considerations.

### Command Line Options

``` bash
--mode     : Connection mode (serial or telnet)
--port     : Serial port or telnet port number
--baudrate : Serial baudrate (default: 115200)
--host     : Telnet server host (default: 0.0.0.0)
```

## LED Status Indicator

The LED indicates various system states:

- Cursor blink
- UART errors (overrun, framing, parity)
- Keyboard activity
- PS/2 errors
- Scroll operation in progress

## Known Limitations

1. No graphics character set support
2. No alternate keypad mode
3. Fixed character set (ASCII 32-126)
4. Fixed UART parameters
5. Hardware scrolling operations require timing considerations

## Error Handling

The terminal provides visual feedback through the LED for:

- UART overrun errors
- UART framing errors
- UART parity errors
- PS/2 keyboard frame errors
- Scroll buffer busy states

## Technical Notes

- Core Clock: 29.4MHz
- Video output compatible with standard VGA/HDMI displays
- Full hardware implementation with no CPU requirements
- 25-row buffer implementation (24 visible + 1 scroll)
- Synchronous scroll operations with busy/done signaling
[Previous sections remain unchanged until Technical Notes]

## Technical Architecture

### Core Components

1. **Terminal Control Modules**

- **VT52_terminal**: Top-level module integrating all components
- **Command Handler**: Processes VT52 commands and screen operations
- **8251 like UART**: Serial communication at 115200 baud, 8N1

2. **Display Modules**

- **Character Buffer**: 25-row display buffer with hardware scrolling
  - 24 visible rows + 1 scroll buffer row
  - Synchronous read/write operations
  - Hardware-accelerated scroll operations

- **Character ROM**: Font storage and rendering
  - 4K x 8 ROM using Terminus Latin-1 Font 8x16
  - 1K x 8 ROM using Original VT52 Font 8x8
  - Synchronous font data access

- **Video Generator**: Display timing and rendering
  - VGA/HDMI signal generation
  - Character and cursor rendering
  - Blanking signal control
  - Close to original VT52 timing

3. **Input Processing Modules**

- **Input Multiplexer**: Input stream arbitration
  - Prioritizes keyboard input over UART
  - Handshaked data transfer
  - Source tracking (keyboard/UART)

- **Keyboard Controller**: PS/2 keyboard interface
  - Full PS/2 protocol implementation
  - Keycode to ASCII conversion
  - Modifier key handling (Shift, Control, Meta)
  - Error detection and reporting
  - Special key sequence processing
  - Repeating key support on appropriate keys

- **Keymap ROM**: Key translation tables
  - 2KB ROM for keycode mapping
  - Multiple keyboard planes (normal, shifted, caps)
  - Extended keycode support

4. **Cursor Management**

- **Cursor**: Position and state tracking
  - X/Y coordinate management
  - Synchronous position updates
  - Integration with command handler

- **Cursor Blinker**: Visual cursor control
  - ~1Hz blink rate using 6-bit counter
  - vblank-synchronized timing
  - Reset on cursor movement

5. **Support Modules**

- **Simple Register**: Generic storage element
  - Parameterized width
  - Synchronous operation
  - Reset support

### Data Flow

``` svg
Input Stage:
PS/2 Keyboard → Keyboard Controller →\
                                     Input Multiplexer → Command Handler
UART RX ───────→ UART Controller ───/           ↑            ↓
                        ↑                        |      Character Buffer
                        |                        |            ↓
Keyboard Data ←── Command Handler ←── UART TX ───┘     Character ROM
                                                           ↓
                                                    Video Generator
                                                           ↓
                                                    VGA/HDMI Output
```

This diagram shows:

- Both keyboard and UART inputs being arbitrated by the Input Multiplexer
- Bidirectional UART communication (keyboard data is echoed to UART TX)
- Character ROM providing font data to the Video Generator
- Character Buffer storing the screen contents
- Command Handler coordinating all operations
- Video Generator producing the final display output

### Key Features

1. **Synchronous Design**

- Single 29.4 MHz clock domain
- Clean handshaking between modules
- Proper reset propagation

2. **Input Processing**

- PS/2 protocol with error detection
- Priority-based input arbitration
- Special key sequence handling
- Full modifier key support

3. **Display System**

- Hardware scroll buffer
- Efficient character rendering
- Smooth cursor management
- VGA/HDMI output generation

4. **Error Management**

- PS/2 frame error detection
- UART error detection
- Input overflow prevention
- LED status indication


## Debugging

If you encounter issues:

1. Check the LED status for error conditions and scroll operations
2. Verify UART connections and settings
3. Ensure PS/2 keyboard is properly connected
4. Allow sufficient time for scroll operations to complete
5. Try resetting the core through the OSD menu

## Future Enhancements

Planned features:

1. Graphics character set support
2. Alternate keypad mode
3. Configurable UART parameters
4. Extended character set support
5. Save/restore terminal state
