Altair8800_Mister
=================

![alt text](./images/Altair8800_MiSTer.png)
By Fred VanEijk and Cyril Venditti.

## What is an Altair 8800

<https://en.wikipedia.org/wiki/Altair_8800>

## How to control the MiSTer Altair8800

- To move the cursor use the directional arrow keys (Left – Right – Up – Down).

- Toggle switches
  - SENSE/DATA/ADDRESS
  - OFF/ON
  - STOP/RUN
    - 1 key - On - up
    - 2 or 0 key - Off - down

- Momentary switches
  - SINGLE STEP
  - EXAMINE
  - DEPOSIT
  - RESET
    - 1 key - Up
    - 2 key - Down

- Not implemented switches
  - CLR
  - PROTECT
  - AUX

## Available samples

These samples are accessible through the MiSTer Core OSD (F12) in the "Load Program *.ROM" section.

The .rom files in the repository Altair8800_Mister rtl/roms/games directory should be copied to the fat/games/Altair8800 directory on the MiSTer.

- Empty

      4k bytes of zeroed memory at address 0x0000.

- zeroToseven

      256 bytes of memory with 1st 8 bytes as 0 to 7.
      First press the RESET toggle, then you can use the EXAMINE NEXT to step through 
      the data in memory.  You will see the values 0 to 7 as binary on the data LEDs.
          
- KillBits

      Kill the Bit game by Dean McDaniel, May 15, 1975
      Object: Kill the rotating bit. If you miss the lit bit, another bit turns on leaving two bits to destroy. 
      Quickly toggle the switch, don't leave the switch in the up position. 
      Before starting, make sure all the switches are in the down position.
      see: rtl\roms\source\killbits.asm
       
- SIOEcho (See Serial port section)

      256 bytes to test serial port at port 00/01.
      Just echos the character typed on the terminal.
      see: rtl\roms\source\SIOEcho.asm
  
- StatusLights

      Demonstrate status light combinations.
      Halts the cpu when done so requires a reset of the core.
      Single Step this one.
      see: rtl\roms\source\StatusLights.asm

- Basic4k32 (see Serial port section)

      This is the basic interpreter originally created by Bill Gates and Paul Allen.
      Basic interpreter in 4k ram at 0x0000 with a total of 8k of memory including the interpreter.
      Communication with the serial port requires SENSE swithes to be set to 0xFD.
      
      The Basic4k32 requires the serial port to be setup to interact with it on a serial terminal.  
      The sense switches to be set as follows (note the sense switches are the switches below the upper 8 address LEDs).  

      Basic will not start properly unless the sense switches are set as follows:
      - 15 to 10 ON
      - 9 OFF
      - 8 ON
      The sense switches control some aspects of initializing the serial port on the Altair8800.
      see: rtl\roms\source\basic4k32.asm

## Altair operation

<https://altairclone.com/altair_experience.htm>

## OSD explanation

MiSTer Core OSD (F12 or OSD button) :

- “Load Program *.ROM”

      Do this switch sequence to run a progrm:
      - Turn the ON/OFF switch to ON
      - Insure that the STOP/RUN switch is STOP
      - Load a program by using the "Load Program" to select the rom file and load it into memory.
            Once you select the rom file the Core will place that program in memory.
      Finally do:
      - RESET with the RESET/CLR switch
      - Turn the STOP/RUN switch to RUN alternatively use SINGLE STEP

- “Enable TurnMon"

      Makes available the turn key monitor at address 0xFD00.
      See file "rtl\roms\altair\turnmon.txt".

- “Serial Port"

      Console Port - use the MiSTer console port or SSH
      User IO Port - use the MiSTer user I/O USB 3.1 port
          
- “Reset”

      This will reset the core. Note this is not the same as RESET on the fron panel (which sets the program counter to 0).
      
- “Help”

      This will show this document on the Mister display.  Note this option is on the System OSD display.
  
## Serial port

 We have implemented a serial port as part of the Altair8800 core.  To use it you need to have an I/O Board v5.5 or later with a USER I/O port.  If you do not have this I/O board you can wire directly to the DE10-Nano.

Without the I/O board:

- Any USB to 3.3V (NOT 5.5V) TTL Serial Cable Adapter should work.
  - TX of the TTL Serial Cable Adapter -> SCL Arduino_IO15 pin of the DE-10.
  - RX of the TTL Serial Cable Adapter -> SDA Arduino_IO14 pin of the DE-10.
  - Don't forget to wire the Ground.

With the I/O board:
The User Port (which looks like a USB 3.1A connector) is documented here: <https://github.com/MiSTer-devel/Wiki_MiSTer/wiki/emu---Top-Level-of-a-MiSTer-core>

- Any USB to 3.3V (NOT 5.5V) TTL Serial Cable Adapter should work.
  - TX of the TTL Serial Cable Adapter -> RX/SCL/D+ pin 3 of the User Port.
  - RX of the TTL Serial Cable Adapter -> TX/SDA/D- pin 2 of the User Port.
  - Don't forget to wire the Ground -> GND pin 4 of the User Port.
  
Use Putty or TeraTerm as a client and use the 19200 baud setting at 8 bits and no parity (this is required to run the Basic4k32 example).

This cable should work fine.
<https://a.co/d/dMlEKn4>

with this USB 3.0 adapter
<https://a.co/d/1VpqE5a>

![alt text](./images/DE-10_Serial.png)
  
#### For SSH with PuTTY

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
     screen /dev/ttyS1 19200
     ```

   - Replace `/dev/ttyS1` with the correct device identifier
   - Change 19200 to the appropriate baud rate if different

3. Enable Flow Control:
   - Use `stty`

     ``` bash
     stty -F /dev/ttyS1 crtscts
     ```

   - Replace `/dev/ttyS1` with the correct device identifier
   - This is done before the screen command

#### STEPS TO CONNECT CONSOLE PORT - direct serial mode

Assumes your MiSTer Console port is connected at COM4

reboot mister

connect to console com4 at 115200 with putty

login
  - un:root
  - pw:1

load altair core

select console port in osd

screen /dev/ttyS1 19200

set sense switches on Altair front panel
  - 15 to 10 on
  - 9 off
  - 8 on

select on switch

select run switch

select basic4k32 in osd

press load program in osd

MEMORY SIZE?
TERMINAL WIDTH?
WANT SIN? Y

4823 BYTES FREE

BASIC VERSION 3.2
[4K VERSION]

## Python Serial Terminal for Altair8800_MiSTer

A simple, lightweight serial terminal program written in Python specifically designed to work with the Altair8800_MiSTer core. Features include:

- Clean 80x25 character display with green text on black background
- Hardware serial connection at 19200 baud (8N1)
- True hardware echo handling (no local echo)
- Proper handling of CR+LF sequences for Altair compatibility
- Live TX/RX hex display for debugging
- Status line showing current port and connection settings
- ESC key to exit

### Requirements
- Python 3.x
- pyserial library (`pip install pyserial`)
- tkinter (typically included with Python)

### Usage
1. Connect your TTL Serial Cable Adapter to the MiSTer's User I/O port
2. Run the terminal program: 
   - Default port (COM9): `python term.py`
   - Specify a different port: `python term.py -p COM4`
3. The terminal will connect at 19200 baud
4. Characters typed will be sent to the Altair and displayed when echoed back

Perfect for use with Altair BASIC and other software requiring serial terminal interaction.

### Additional Information

For more details on console connection, refer to the official MiSTer documentation:
[MiSTer Console Connection Guide](https://MiSTer-devel.github.io/MkDocs_MiSTer/advanced/console/)

## Credits

- Inspiration for displaying the Altair8800 front panel:
     <https://timetoexplore.net/blog/arty-fpga-vga-verilog-01>

- Altair8800 front panel image:
     <http://www.vintage-computer.com/altair8800.shtml>
  
- Core:
    <https://github.com/1801BM1/vm80a>

    <https://zeptobars.com/en/read/KR580VM80A-intel-i8080-verilog-reverse-engineering>

    <https://hackaday.com/2015/03/07/looking-inside-the-kr580vm80a-soviet-i8080-clone/>

    <https://jeelabs.org/2016/09/i-never-had-an-intel-8080/>

    <https://github.com/mmicko/s100fpga>

## Known issues

Depending on your monitor resolution the Altair8800 front panel might not be complete or centered.

## Not implemented

The following switches/functions are not implemented:

- CLR
- PROTECT
- AUX
