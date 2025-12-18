MiSTer MultiComp
================

Port of Grant Searle's MultiComp to the MiSTer.

Ported by Cyril Venditti and Fred VanEijk.

Updated by S0urceror to use MiSTer image files, use all 4 machine types and have the MiSTer
UART connected to serial interface 2 of the core. The latter allows to use the core remotely.

## Using the MiSTer Serial Terminal/Console

### Connection Methods

1. USB: Connect the console port from the MiSTer FPGA to your computer using a USB cable.  

2. Network: Use SSH to connect to the MiSTer FPGA if you have a Wireless or Ethernet connection.

3. USB/Serial cable: For more information see the Serial Port section of the Altair8800_MiSTer repository:  <https://github.com/MiSTer-devel/Altair8800_MiSTer>

### Setting Up the Connection

#### For UART/Serial with PuTTY

- Connect at 115200 baud, 8 bits, no parity to the COM port.

#### USB to serial cable connection

##### User Port - extra USB 3.1A style connector on MiSTer

| USB  |  P7 |  Name  | PIN  |   Mister | emu wire |
|---|---|---|---|---|---|
|1  |  +5V |   +5V|
|2  |  2  |  TX   | SDA  |  AH9   | USER_IO[1] |
|3  |  1    |RX   | SCL   | AG11   | USER_IO[0] |
|4  |  GND   | GND|
|5  |  8   | DSR  |  IO10  |  AF15  |  USER_IO[5]|
|6  |  7   | DTR  |  IO11  | AG16   | USER_IO[4]|
|7  |  6   | CTS  |  IO12  |  AH11  |  USER_IO[3]|
|8  |  5   | RTS  |  IO13  |  AH12  |  USER_IO[2]|
|9  |  10  |  IO6 |   IO8  |  AF17  |  USER_IO[6]|
|10 |   Shield |   Shield |

##### FT232 USB to serial cable

|wire |name | mister usb IO port|
|---|---|---|
| Red|5V|N/C|
| Black|GND|GND|
| White|RXD|2|
| Green|TXD|3|
| Yellow|RTS|7|
| Blue|CTS|8|

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
     screen /dev/ttyS1 115200
     ```

   - Replace `/dev/ttyS1` with the correct device identifier
   - Change 115200 to the appropriate baud rate if different

3. Enable Flow Control:
   - Use `stty`

     ``` bash
     stty -F /dev/ttyS1 crtscts
     ```

   - Replace `/dev/ttyS1` with the correct device identifier
   - This is done before the screen command

### Additional Information

For more details on console connection, refer to the official MiSTer documentation:
[MiSTer Console Connection Guide](https://MiSTer-devel.github.io/MkDocs_MiSTer/advanced/console/)

## The MiSTer OSD allows the access to five machines

### Z80 CP/M

You can now use both an external SDCard in the secondary slot and/or select the image file within MiSTer. Whatever you like.

### Formatting the SD Card and Installing CP/M

Note this procedure has to be performed from a tty terminal as descibed above.

#### Formatting the Drive

1. Load the Intel-HEX dump of the `FORMAT` program into memory by copying the contents of `FORM128.HEX` (for 128MB SD card utilization) into the terminal window.
2. The `FORMAT` program will reside at memory address `$5000` when loaded. To start the formatting process, execute the program by typing `G5000` and pressing ENTER.
3. You will see the following message:

```
CP/M Formatter by G. Searle 2012
```

4. After a few seconds, the formatting process will display:

```
ABCDEFGHIJKLMNOP
Formatting complete
```

Each drive is 8MB, so a 128MB SD card will have drives labeled A: to P:.

#### Installing CP/M

CP/M is installed on the first track of the disk. When booted, the first track is read into memory and executed. To install CP/M, follow these steps:

1. Load the Intel-HEX dump of CP/M by copying the contents of `CPM22.HEX` into the terminal window (this takes about 10 seconds).
2. Load the Intel-HEX dump of the CBIOS by copying the contents of `CBIOS128.HEX` (for 128MB total drive space) into the terminal window (this takes about 3 seconds).
3. Load the Intel-HEX dump of `PUTSYS` by copying the contents of `PUTSYS.HEX` into the terminal window.

The `PUTSYS` program also resides at memory address `$5000`. To transfer CP/M and CBIOS to the disk, execute `PUTSYS` by typing `G5000` and pressing ENTER. You will see:

```
CP/M System Transfer by G. Searle 2012
System transfer complete
```

At this point, CP/M is installed and ready for boot. You can now proceed with installing applications.

#### Boot CP/M from image file

Note that currently the `DOWNLOAD.COM` program is not working reliably (we hope to fix this in the future).  To get around the issues with `DOWNLOAD.COM` we have added the cpm image file and some Python based utilities, thus being able to get a working and custamizable CP/M sytem up and running.

In the CPM-sd-image directory, you will find a zip file that contains a cmp.img file that can be copied to the /media/fat/games/MultipComp directory.  This file can be used to boot CP/M without the SD card.  It contains the structure for disks A thru P with A having the DOWNLOAD program and other utilities available.  Use this as a strating point to place CP/M applications on the image.  See the Installing Applications section at <http://searle.x10host.com/Multicomp/cpm/fpgaCPM.html#InstallingCPM>.  

Note the process for this is mostly described in PART 2 - Using the Windows packager program.  The packager program is in windowsApp.  Again, this process requires the use of the tty terminal not the console, as you will be pasting the file data into the terminal.

We have also added a zip file in the CPM-sd-image directory with a set of application pre installed.  See cpm-apps.zip.  This file can also be copied to the /media/fat/games/MultipComp directory and mounted.  It contains 5 drives A,C,D,E, and F where A still only has the DOWNLOAD program and the other drives contain the following.  The cpm.zip file contains just the basic utilities described in the  [CPM-sd-image](CPM-sd-image/README.MD)  directory.

| C:              | D:                | E:               | F:              |
|-----------------|-------------------|------------------|-----------------|
| 0_FILES.TXT     | 0_GAMES           | 0_OLDUTILS       | 0_NEWUTILS      |
| 1_BDS_TINY_C    | 1_MUMATHSIMP      | 1_F80M80BASIC    | 1_ROMS          |
| 2_APL           | 2_CROSSTALK       | 2_AZTEC_C_106D   | 2_ZSYSTEM       |
| 3_JANUS_ADA15   | 3_QTERM43         | 3_TPASCAL3       | 3_MICROPRO      |
| 4_MS_COBOL      | 4_CLINK           | 4_DXFORTH401     | 4_MULTIPLAN     |
| 5_PILOT         | 5_SUPERSFTUTIL    | 5_PLI14          | 5_DBASEII       |
| 6_SYSLIB        | 6_RCPM            | 6_ALGOLM         | 6_DWG_APPS      |
| 7_BBC BASIC     | 7_DDTZ SOURCES    | 7_SUPERCALC      | 8_MICROSHELL    |

Note the use of user numbers here i.e. 0_, 1_ etc..  
(Not all the applications were tested to run, so you are on your own)

The applications were obtained from the Obsolescence Guaranteed site.

Included in the CPM-sd-image directory are also some python scripts to initialize/build the image for the CP/M disks.  Along with a script in the transient packages directory that can extract the .COM files from the package (note this was used to provide some content to build the cpm.img file provided in CPM-sd-image directory).

To use the Python scripts we recommend using Visual Studio Code and opening the MultiComp_MiSTer directory as its project location.  Them just run the Python scripts from within Visual Studio Code.

__Other useful links.__

For convenience you can use the Multicomp FPGA - CP/M Demo Disk from Obsolescence Guaranteed:
<http://obsolescence.wixsite.com/obsolescence/multicomp-fpga-cpm-demo-disk>

After you have flashed the CP/M Demo Disk to the SD Card you will have to use the secondary SD Card on the MiSTer on the I/O Board:
<https://github.com/MiSTer-devel/Wiki_MiSTer/wiki/IO-Board>

Using CP/M - from Grant Searle website:
<http://searle.x10host.com/Multicomp/cpm/fpgaCPM.html>

DeRamp - This website focuses on early personal computers from the mid 70s into the early 80s. Here you'll find resources for restoring and maintaining many of the great computers and peripherals from this era, in addition it has a Downloads section where you can find the bits for many applications. <https://deramp.com/>

### Z80 Basic

SGN, INT, ABS ,USR, FRE, INP, POS, SQR, RND ,LOG, EXP, COS, SIN, TAN, ATN, PEEK ,DEEK ,LEN, STR$, VAL ,ASC, CHR$ ,LEFT$,
RIGHT$, MID$, END, FOR, NEXT, DATA, INPUT, DIM, READ, LET, GOTO, RUN, IF, RESTORE, GOSUB, RETURN, REM, STOP, OUT, ON,
NULL, WAIT,  DEF, POKE, DOKE, LINES, CLS, WIDTH, MONITOR, PRINT, CONT, LIST, CLEAR, NEW, TAB, TO, FN, SPC, THEN, NOT,
STEP, +, -, *, /, ^, AND, OR, >, <, =

PLUS additional implementations here (making it version 4.7b):

HEX$(nn) - convert a SIGNED integer (-32768 to +32767) to a string containing the hex value

BIN$(nn) - convert a SIGNED integer (-32768 to +32767) to a string containing the binary value

&Hnn - interpret the value after the &H as a HEX value (signed 16 bit)

&Bnn - interpret the value after the &B as a BINARY value (signed 16 bit)

### 6502 Basic - No SD card support (No CSAVE/CLOAD)

END, FOR, NEXT, DATA, INPUT, DIM, READ, LET, GOTO, RUN, IF, RESTORE, GOSUB, RETURN, REM, STOP, ON, NULL, WAIT, DEF, POKE, PRINT,
CONT, LIST, CLEAR, NEW, TAB(, TO, FN, SPC(, THEN, NOT, STEP, SGN, INT, ABS, USR, FRE, POS, SQR, RND, LOG, EXP, COS, SIN, TAN, ATN,
PEEK, LEN, STR$, VAL, ASC, CHR$, LEFT$, RIGHT$, MID$, +, -, *, /, ^, AND, OR, >, +, <

### 6809 Basic - No SD card support(No CSAVE/CLOAD)

FOR, GO, REM, ELSE, IF, DATA, PRINT, ON GOSUB, ON GOTO, INPUT, LINE INPUT, END, NEXT, DIM, READ, RUN, RESTORE, RETURN, STOP, POKE,
CONT, LIST, CLEAR, NEW, EXEC, TAB, TO, SUB, THEN, NOT, STEP, +, -, *, /, ^, AND, OR, >, =, <, DEL, DEF, LET, RENUM, FN, &, &H, TRON,
TROFF, EDIT, SGN, INT, ABS, USR, RND, SIN, PEEK, LEN, STR$, VAL, ASC, CHR$, LEFT$, RIGHT$, MID$, INKEY$, MEM, ATN, COS, TAN, EXP, FIX,
LOG, SQR, HEX$, VARPTR, INSTR, STRING$, MID$ (MODIFICATION), POS

<http://searle.x10host.com/Multicomp/#BASICKeywords>

### 6809 Camel Forth

A 6809 implementation of Camel Forth

# MultiComp OSD Configuration

This section describes the On-Screen Display menu configuration for the MultiComp system, providing control over CPU selection, storage, and communication parameters.

## Menu Structure

### System Control

- __Mount *.IMG__: Provide the image in the games/Multicomp directory if no image is specified it will attempt to use the secondary SD card
- __Reset after Mount__: Configures system behavior after mounting storage - Options: No, Yes
- __Reset__: System reset function

### CPU and ROM Configuration

- __CPU-ROM Selection__:
- Z80 with CP/M
- Z80 with BASIC
- 6502 with BASIC
- 6809 with BASIC
- 6809 Forth

### Communication Settings

- __Baud Rate__:
- 115200
- 38400
- 19200
- 9600
- 4800
- 2400
- __Serial Port__:
- Console Port - use the MiSTer console port
- User IO Port - use the MiSTer user I/O USB 3.1 port
- __Flow Control__:
- None - no hardware flow control
- RTS/CTS - enable hardware flow control using RTS/CTS signals

### Additional Information
The OSD includes version information and build date tracking. This configuration interface provides comprehensive control over the MultiComp's core functionality, allowing users to switch between different CPU architectures, operating systems, and I/O configurations.

The menu system is designed for straightforward navigation and configuration of the MultiComp's essential features, making it accessible for both basic setup and advanced customization needs.

## Troubleshooting

### Serial Communication Issues

- Only the Z80 supports the external uart at this time
- If no response when typing:
  - Verify correct baud rate is selected
  - Check that the correct serial port is selected (Console vs User IO)
  - Try enabling/disabling flow control
  - For User IO port, verify cable connections match pinout documentation

### Storage Issues

- If unable to access CP/M:
- Verify Secondary SD card is properly formatted or an image is selected in the OSD
- Try toggling "Reset after Mount" option
- Once either the secondary SD card is selected or the Image file is selected a complete MiSTer re-start is required to change the selection i.e. it can not be changed with a reset of the core.

### System Stability

- 6809 Basic had known reset issues (inherited from original design) the core was actually being reset but only a warm reset, now it supports a cold or warm reset with a prompt
- If system becomes unresponsive:
  - Use OSD Reset function
  - Try power cycling the MiSTer
  - Verify correct CPU-ROM selection for your intended use

### Known Limitations

- If the DOWNLOAD\.COM program has reliability issues in CP/M use a slower baud rate, we have had some sucess at 2400 and 9600 baud, 115200 baud seems to consistantly drop characters even with flow control enabled
- 6502 and 6809 Basic variants do not support SD card operations (no CSAVE/CLOAD)\

### License

__Software and VHDL project download link__

By downloading these files you must agree to the following: The original
copyright owners of ROM contents are respectfully acknowledged.  Use of the
contents of any file within your own projects is permitted freely, but any
publishing of material containing whole or part of any file distributed
here, or derived from the work that I have done here will contain an
acknowledgment back to myself, Grant Searle, and a link back to this page.
Any file published or distributed that contains all or part of any file
arom this page must be made available free of charge.

### Original Author

Grant Searle

### URL

[Grant's MULTICOMP pick and mix computer](http://searle.x10host.com/Multicomp/)

# MiSTer MultiComp BASIC Keywords Reference

## Keywords by Category

### Mathematical Functions

| Keyword | Z80 | 6502 | 6809 | Description | Usage Example |
|---------|-----|------|------|-------------|---------------|
| ABS | ✓ | ✓ | ✓ | Returns absolute value | `X = ABS(-5)` |
| ATN | ✓ | ✓ | ✓ | Returns arctangent | `A = ATN(1)` |
| COS | ✓ | ✓ | ✓ | Returns cosine | `C = COS(3.14159/2)` |
| EXP | ✓ | ✓ | ✓ | Returns e raised to power | `E = EXP(2)` |
| FIX | - | - | ✓ | Truncates decimal portion | `F = FIX(3.7)` |
| INT | ✓ | ✓ | ✓ | Returns integer portion | `I = INT(5.7)` |
| LOG | ✓ | ✓ | ✓ | Returns natural logarithm | `L = LOG(100)` |
| SGN | ✓ | ✓ | ✓ | Returns sign of number (-1,0,1) | `S = SGN(-42)` |
| SIN | ✓ | ✓ | ✓ | Returns sine | `S = SIN(3.14159/2)` |
| SQR | ✓ | ✓ | ✓ | Returns square root | `R = SQR(16)` |
| TAN | ✓ | ✓ | ✓ | Returns tangent | `T = TAN(0.785)` |

### String Functions

| Keyword | Z80 | 6502 | 6809 | Description | Usage Example |
|---------|-----|------|------|-------------|---------------|
| ASC | ✓ | ✓ | ✓ | Returns ASCII value of character | `A = ASC("A")` |
| CHR$ | ✓ | ✓ | ✓ | Returns character for ASCII value | `C$ = CHR$(65)` |
| INSTR | - | - | ✓ | Searches for substring | `I = INSTR(A$, "FIND")` |
| LEFT$ | ✓ | ✓ | ✓ | Returns leftmost characters | `L$ = LEFT$("HELLO", 2)` |
| LEN | ✓ | ✓ | ✓ | Returns string length | `L = LEN("TEST")` |
| MID$ | ✓ | ✓ | ✓ | Returns substring | `M$ = MID$("HELLO", 2, 2)` |
| RIGHT$ | ✓ | ✓ | ✓ | Returns rightmost characters | `R$ = RIGHT$("WORLD", 3)` |
| STR$ | ✓ | ✓ | ✓ | Converts number to string | `S$ = STR$(123)` |
| STRING$ | - | - | ✓ | Creates string of repeated characters | `S$ = STRING$(5, "*")` |
| VAL | ✓ | ✓ | ✓ | Converts string to number | `V = VAL("123")` |

### Program Control

| Keyword | Z80 | 6502 | 6809 | Description | Usage Example |
|---------|-----|------|------|-------------|---------------|
| CONT | ✓ | ✓ | ✓ | Continues program execution | `CONT` |
| END | ✓ | ✓ | ✓ | Ends program | `END` |
| FOR/NEXT | ✓ | ✓ | ✓ | Loop structure | `FOR I=1 TO 10 : PRINT I : NEXT I` |
| GOSUB | ✓ | ✓ | ✓ | Calls subroutine | `GOSUB 1000` |
| GOTO | ✓ | ✓ | ✓ | Jumps to line number | `GOTO 100` |
| IF/THEN | ✓ | ✓ | ✓ | Conditional execution | `IF X=5 THEN PRINT "YES"` |
| ON GOSUB | - | - | ✓ | Multiple branch subroutine | `ON X GOSUB 100,200,300` |
| ON GOTO | - | - | ✓ | Multiple branch jump | `ON X GOTO 100,200,300` |
| RETURN | ✓ | ✓ | ✓ | Returns from subroutine | `RETURN` |
| STOP | ✓ | ✓ | ✓ | Halts program execution | `STOP` |

### Data and Variables

| Keyword | Z80 | 6502 | 6809 | Description | Usage Example |
|---------|-----|------|------|-------------|---------------|
| DATA | ✓ | ✓ | ✓ | Stores program data | `DATA 100,200,"TEXT"` |
| DEF FN | ✓ | ✓ | ✓ | Defines function | `DEF FNA(X)=X*X+2` |
| DIM | ✓ | ✓ | ✓ | Declares array dimensions | `DIM A(10),B$(20)` |
| INPUT | ✓ | ✓ | ✓ | Accepts user input | `INPUT "Name?";N$` |
| LET | ✓ | ✓ | ✓ | Assigns variable value | `LET A=5` or `A=5` |
| LINE INPUT | - | - | ✓ | Inputs entire line | `LINE INPUT "Text?";A$` |
| READ | ✓ | ✓ | ✓ | Reads DATA values | `READ A,B,C$` |
| RESTORE | ✓ | ✓ | ✓ | Resets DATA pointer | `RESTORE` |

### System and Memory

| Keyword | Z80 | 6502 | 6809 | Description | Usage Example |
|---------|-----|------|------|-------------|---------------|
| DEEK | ✓ | - | - | Reads word from memory | `D = DEEK(16384)` |
| DOKE | ✓ | - | - | Writes word to memory | `DOKE 16384,12345` |
| FRE | ✓ | ✓ | - | Returns free memory | `F = FRE(0)` |
| INP | ✓ | - | - | Reads from I/O port | `I = INP(255)` |
| MEM | - | - | ✓ | Returns memory size | `M = MEM` |
| OUT | ✓ | - | - | Writes to I/O port | `OUT 255,10` |
| PEEK | ✓ | ✓ | ✓ | Reads byte from memory | `P = PEEK(16384)` |
| POKE | ✓ | ✓ | ✓ | Writes byte to memory | `POKE 16384,255` |
| USR | ✓ | ✓ | ✓ | Calls machine language routine | `U = USR(32768)` |
| VARPTR | - | - | ✓ | Returns variable address | `V = VARPTR(A)` |

### Program Editing

| Keyword | Z80 | 6502 | 6809 | Description | Usage Example |
|---------|-----|------|------|-------------|---------------|
| CLEAR | ✓ | ✓ | ✓ | Clears variables | `CLEAR` |
| CLS | ✓ | - | - | Clears screen | `CLS` |
| DEL | - | - | ✓ | Deletes program lines | `DEL 100-200` |
| EDIT | - | - | ✓ | Edits program line | `EDIT 100` |
| LIST | ✓ | ✓ | ✓ | Lists program | `LIST` or `LIST 100-200` |
| NEW | ✓ | ✓ | ✓ | Clears program | `NEW` |
| RENUM | - | - | ✓ | Renumbers program lines | `RENUM 100,10` |
| RUN | ✓ | ✓ | ✓ | Executes program | `RUN` or `RUN 100` |
| TRON/TROFF | - | - | ✓ | Trace mode on/off | `TRON` or `TROFF` |

### Z80 BASIC Specific Extensions (v4.7b)

| Keyword | Description | Usage Example |
|---------|-------------|---------------|
| HEX$(nn) | Converts signed integer to hex string | `H$ = HEX$(255)` |
| BIN$(nn) | Converts signed integer to binary string | `B$ = BIN$(15)` |
| &Hnn | Interprets nn as hexadecimal value | `X = &H1F` |
| &Bnn | Interprets nn as binary value | `Y = &B1010` |

### Operators

| Operator | Z80 | 6502 | 6809 | Description | Usage Example |
|----------|-----|------|------|-------------|---------------|
| + | ✓ | ✓ | ✓ | Addition | `A = B + C` |
| - | ✓ | ✓ | ✓ | Subtraction | `X = Y - Z` |
| * | ✓ | ✓ | ✓ | Multiplication | `P = Q * R` |
| / | ✓ | ✓ | ✓ | Division | `D = N / 2` |
| ^ | ✓ | ✓ | ✓ | Exponentiation | `E = 2 ^ 3` |
| AND | ✓ | ✓ | ✓ | Logical AND | `IF A>0 AND B<10 THEN...` |
| OR | ✓ | ✓ | ✓ | Logical OR | `IF X=0 OR Y=0 THEN...` |
| NOT | ✓ | ✓ | ✓ | Logical NOT | `IF NOT A THEN...` |
| > | ✓ | ✓ | ✓ | Greater than | `IF X > 10 THEN...` |
| < | ✓ | ✓ | ✓ | Less than | `IF Y < 5 THEN...` |
| = | ✓ | ✓ | ✓ | Equal to | `IF A = B THEN...` |
| & | - | - | ✓ | Bitwise AND | `R = X & Y` |

Notes:

1. Z80 BASIC is the most commonly used version for CP/M systems
2. 6502 BASIC is a Microsoft BASIC variant
3. 6809 BASIC has the most extensive command set but lacks storage commands
4. None of the 6502 and 6809 variants support CSAVE/CLOAD operations

Each example shows the most common usage pattern for the command. Many commands have additional optional parameters or alternate syntaxes not shown in these basic examples.

# BASIC Programming Examples

A collection of example programs demonstrating various BASIC programming concepts and commands.

Some of these may only run on the 6809.

## Number Guessing Game

This program demonstrates input handling, loops, and conditional statements. The computer picks a random number and the player has 10 tries to guess it.

```basic
10 REM Number Guessing Game
20 CLS
30 PRINT "Number Guessing Game!"
40 LET N = INT(RND(1) * 100) + 1
50 LET TRIES = 0
60 PRINT "Guess a number between 1 and 100"
70 INPUT "Your guess: "; G
80 LET TRIES = TRIES + 1
90 IF G = N THEN GOTO 150
100 IF G < N THEN PRINT "Too low!"
110 IF G > N THEN PRINT "Too high!"
120 IF TRIES < 10 THEN GOTO 70
130 PRINT "Sorry, you've run out of tries. The number was"; N
140 GOTO 160
150 PRINT "Congratulations! You got it in"; TRIES; "tries!"
160 INPUT "Play again (Y/N)? "; A$
170 IF LEFT$(A$, 1) = "Y" OR LEFT$(A$, 1) = "y" THEN GOTO 40
180 END
```

Key concepts:
- Random number generation
- Input validation
- Conditional branching
- Loop control
- String comparison

## String Manipulation

This example demonstrates various string operations and functions available in BASIC.

```basic
10 REM String Manipulation Demo
20 LET A$ = "BASIC Programming"
30 PRINT "Original string: "; A$
40 PRINT "Length: "; LEN(A$)
50 PRINT "First 5 chars: "; LEFT$(A$, 5)
60 PRINT "Last 7 chars: "; RIGHT$(A$, 7)
70 PRINT "Middle 6 chars: "; MID$(A$, 7, 6)
80 FOR I = 1 TO LEN(A$)
90 PRINT MID$(A$, I, 1);
100 NEXT I
110 PRINT
120 END
```

Key concepts:
- String functions (LEN, LEFT$, RIGHT$, MID$)
- Character-by-character processing
- String concatenation
- FOR/NEXT loops with strings

## Math Functions Calculator

A simple calculator program that demonstrates mathematical functions and structured programming using subroutines.

```basic
10 REM Math Functions Calculator
20 PRINT "Math Functions Calculator"
30 PRINT "1. Square Root"
40 PRINT "2. Sine"
50 PRINT "3. Cosine"
60 PRINT "4. Tangent"
70 PRINT "5. Exit"
80 INPUT "Choose a function (1-5): "; C
90 IF C = 5 THEN END
100 INPUT "Enter a number: "; N
110 ON C GOSUB 200, 300, 400, 500
120 GOTO 20
200 PRINT "Square root of"; N; "is"; SQR(N)
210 RETURN
300 PRINT "Sine of"; N; "is"; SIN(N)
310 RETURN
400 PRINT "Cosine of"; N; "is"; COS(N)
410 RETURN
500 PRINT "Tangent of"; N; "is"; TAN(N)
510 RETURN
```

Key concepts:
- Subroutines with GOSUB/RETURN
- ON GOSUB branching
- Mathematical functions
- Menu-driven interface

## Array Operations

Demonstrates array handling, loops, and basic statistical calculations.

```basic
10 REM Array Operations
20 DIM A(10)
30 REM Fill array with numbers
40 FOR I = 1 TO 10
50 LET A(I) = I * 2
60 NEXT I
70 REM Calculate sum and average
80 LET S = 0
90 FOR I = 1 TO 10
100 LET S = S + A(I)
110 NEXT I
120 PRINT "Sum:"; S
130 PRINT "Average:"; S/10
140 REM Find maximum value
150 LET M = A(1)
160 FOR I = 2 TO 10
170 IF A(I) > M THEN LET M = A(I)
180 NEXT I
190 PRINT "Maximum value:"; M
200 END
```

Key concepts:
- Array declaration and initialization
- Array traversal
- Running sums
- Finding maximum values
- Basic statistics

## Simple Data Management

Shows how to work with DATA statements for storing and accessing program data.

```basic
10 REM Simple Data Management
20 DIM N$(5), A(5)
30 FOR I = 1 TO 5
40 READ N$(I), A(I)
50 NEXT I
60 REM Print all records
70 PRINT "Name", "Age"
80 PRINT "----", "---"
90 FOR I = 1 TO 5
100 PRINT N$(I), A(I)
110 NEXT I
120 DATA "John", 25, "Mary", 32, "Bob", 45, "Alice", 28, "Tom", 19
130 END
```

Key concepts:
- DATA statements
- READ operations
- Parallel arrays
- Formatted output
- String and numeric arrays

## Custom Function Definition

Demonstrates how to create and use user-defined functions.

```basic
10 REM Custom Function Demo
20 DEF FNC(X) = 5 * X^2 + 2 * X + 1
30 DEF FNF(X) = (X * 9/5) + 32
40 INPUT "Enter a number: "; N
50 PRINT "Quadratic result:"; FNC(N)
60 PRINT N; "Celsius ="; FNF(N); "Fahrenheit"
70 END
```

Key concepts:
- Function definition with DEF FN
- Mathematical expressions
- Temperature conversion
- Function parameter passing

Each of these examples can be extended or modified to create more complex programs. Note that some BASIC dialects may require slight modifications to these programs depending on the specific implementation.


# Forth Language Glossary

## Guide to Stack Diagrams

* `R:` = return stack
* `c` = 8-bit character
* `flag` = boolean (0 or -1)
* `n` = signed 16-bit
* `u` = unsigned 16-bit
* `d` = signed 32-bit
* `ud` = unsigned 32-bit
* `+n` = unsigned 15-bit
* `x` = any cell value
* `i*x j*x` = any number of cell values
* `a-addr` = aligned address
* `c-addr` = character address
* `p-addr` = I/O port address
* `sys` = system-specific

*Refer to ANS Forth document for more details.*

## Low-Level Words (Written in CODE)

### ANS Forth Core Words

These are required words whose definitions are specified by the ANS Forth document.

| Word | Stack Effect | Description |
|------|--------------|-------------|
| `!` | `x a-addr --` | Store cell in memory |
| `+` | `n1/u1 n2/u2 -- n3/u3` | Add n1+n2 |
| `+!` | `n/u a-addr --` | Add cell to memory |
| `-` | `n1/u1 n2/u2 -- n3/u3` | Subtract n1-n2 |
| `<` | `n1 n2 -- flag` | Test n1<n2, signed |
| `=` | `x1 x2 -- flag` | Test x1=x2 |
| `>` | `n1 n2 -- flag` | Test n1>n2, signed |
| `>R` | `x -- R: -- x` | Push to return stack |
| `?DUP` | `x -- 0 \| x x` | DUP if nonzero |
| `@` | `a-addr -- x` | Fetch cell from memory |
| `0<` | `n -- flag` | True if TOS negative |
| `0=` | `n/u -- flag` | Return true if TOS=0 |
| `1+` | `n1/u1 -- n2/u2` | Add 1 to TOS |
| `1-` | `n1/u1 -- n2/u2` | Subtract 1 from TOS |
| `2*` | `x1 -- x2` | Arithmetic left shift |
| `2/` | `x1 -- x2` | Arithmetic right shift |
| `AND` | `x1 x2 -- x3` | Logical AND |
| `CONSTANT` | `n --` | Define a Forth constant |
| `C!` | `c c-addr --` | Store char in memory |
| `C@` | `c-addr -- c` | Fetch char from memory |
| `DROP` | `x --` | Drop top of stack |
| `DUP` | `x -- x x` | Duplicate top of stack |
| `EMIT` | `c --` | Output character to console |
| `EXECUTE` | `i*x xt -- j*x` | Execute Forth word 'xt' |
| `EXIT` | `--` | Exit a colon definition |
| `FILL` | `c-addr u c --` | Fill memory with char |
| `I` | `-- n R: sys1 sys2 -- sys1 sys2` | Get the innermost loop index |
| `INVERT` | `x1 -- x2` | Bitwise inversion |
| `J` | `-- n R: 4*sys -- 4*sys` | Get the second loop index |
| `KEY` | `-- c` | Get character from keyboard |
| `LSHIFT` | `x1 u -- x2` | Logical L shift u places |
| `NEGATE` | `x1 -- x2` | Two's complement |
| `OR` | `x1 x2 -- x3` | Logical OR |
| `OVER` | `x1 x2 -- x1 x2 x1` | Per stack diagram |
| `ROT` | `x1 x2 x3 -- x2 x3 x1` | Per stack diagram |
| `RSHIFT` | `x1 u -- x2` | Logical R shift u places |
| `R>` | `-- x R: x --` | Pop from return stack |
| `R@` | `-- x R: x -- x` | Fetch from return stack |
| `SWAP` | `x1 x2 -- x2 x1` | Swap top two items |
| `UM*` | `u1 u2 -- ud` | Unsigned 16x16->32 mult. |
| `UM/MOD` | `ud u1 -- u2 u3` | Unsigned 32/16->16 div. |
| `UNLOOP` | `-- R: sys1 sys2 --` | Drop loop parameters |
| `U<` | `u1 u2 -- flag` | Test u1<n2, unsigned |
| `VARIABLE` | `--` | Define a Forth variable |
| `XOR` | `x1 x2 -- x3` | Logical XOR |

### ANS Forth Extensions

Optional words specified by the ANS Forth document.

| Word | Stack Effect | Description |
|------|--------------|-------------|
| `<>` | `x1 x2 -- flag` | Test not equal |
| `BYE` | `i*x --` | Return to CP/M |
| `CMOVE` | `c-addr1 c-addr2 u --` | Move from bottom |
| `CMOVE>` | `c-addr1 c-addr2 u --` | Move from top |
| `KEY?` | `-- flag` | Return true if char waiting |
| `M+` | `d1 n -- d2` | Add single to double |
| `NIP` | `x1 x2 -- x2` | Per stack diagram |
| `TUCK` | `x1 x2 -- x2 x1 x2` | Per stack diagram |
| `U>` | `u1 u2 -- flag` | Test u1>u2, unsigned |

### Private Extensions

Words unique to CamelForth.

| Word | Stack Effect | Description |
|------|--------------|-------------|
| `(DO)` | `n1\|u1 n2\|u2 -- R: -- sys1 sys2` | Run-time code for DO |
| `(LOOP)` | `R: sys1 sys2 -- \| sys1 sys2` | Run-time code for LOOP |
| `(+LOOP)` | `n -- R: sys1 sys2 -- \| sys1 sys2` | Run-time code for +LOOP |
| `><` | `x1 -- x2` | Swap bytes |
| `?BRANCH` | `x --` | Branch if TOS zero |
| `BDOS` | `DE C -- A` | Call CP/M BDOS |
| `BRANCH` | `--` | Branch always |
| `LIT` | `-- x` | Fetch inline literal to stack |
| `RP!` | `a-addr --` | Set return stack pointer |
| `RP@` | `-- a-addr` | Get return stack pointer |
| `SCAN` | `c-addr1 u1 c -- c-addr2 u2` | Find matching char |
| `SKIP` | `c-addr1 u1 c -- c-addr2 u2` | Skip matching chars |
| `SP!` | `a-addr --` | Set data stack pointer |
| `SP@` | `-- a-addr` | Get data stack pointer |
| `S=` | `c-addr1 c-addr2 u -- n` | String compare (n<0: s1<s2, n=0: s1=s2, n>0: s1>s2) |
| `USER` | `n --` | Define user variable 'n' |

## High-Level Words

### ANS Forth Core Words

These are required words whose definitions are specified by the ANS Forth document.

| Word | Stack Effect | Description |
|------|--------------|-------------|
| `#` | `ud1 -- ud2` | Convert 1 digit of output |
| `#S` | `ud1 -- ud2` | Convert remaining digits |
| `#>` | `ud1 -- c-addr u` | End conversion, get string |
| `'` | `-- xt` | Find word in dictionary |
| `(` | `--` | Skip input until ) |
| `*` | `n1 n2 -- n3` | Signed multiply |
| `*/` | `n1 n2 n3 -- n4` | n1*n2/n3 |
| `*/MOD` | `n1 n2 n3 -- n4 n5` | n1*n2/n3, rem & quot |
| `+LOOP` | `adrs -- L: 0 a1 a2 .. aN --` | |
| `,` | `x --` | Append cell to dict |
| `/` | `n1 n2 -- n3` | Signed divide |
| `/MOD` | `n1 n2 -- n3 n4` | Signed divide, rem & quot |
| `:` | `--` | Begin a colon definition |
| `;` | | End a colon definition |
| `<#` | `--` | Begin numeric conversion |
| `>BODY` | `xt -- a-addr` | Address of param field |
| `>IN` | `-- a-addr` | Holds offset into TIB |
| `>NUMBER` | `ud adr u -- ud' adr' u'` | Convert string to number |
| `2DROP` | `x1 x2 --` | Drop 2 cells |
| `2DUP` | `x1 x2 -- x1 x2 x1 x2` | Dup top 2 cells |
| `2OVER` | `x1 x2 x3 x4 -- x1 x2 x3 x4 x1 x2` | Per diagram |
| `2SWAP` | `x1 x2 x3 x4 -- x3 x4 x1 x2` | Per diagram |
| `2!` | `x1 x2 a-addr --` | Store 2 cells |
| `2@` | `a-addr -- x1 x2` | Fetch 2 cells |
| `ABORT` | `i*x -- R: j*x --` | Clear stack & QUIT |
| `ABORT"` | `i*x 0 -- i*x R: j*x -- j*x` | Print msg & abort if x1<>0 |
| `ABS` | `n1 -- +n2` | Absolute value |
| `ACCEPT` | `c-addr +n -- +n'` | Get line from terminal |
| `ALIGN` | `--` | Align HERE |
| `ALIGNED` | `addr -- a-addr` | Align given addr |
| `ALLOT` | `n --` | Allocate n bytes in dict |
| `BASE` | `-- a-addr` | Holds conversion radix |
| `BEGIN` | `-- adrs` | Target for backward branch |
| `BL` | `-- char` | An ASCII space |
| `C,` | `char --` | Append char to dict |
| `CELLS` | `n1 -- n2` | Cells->adrs units |
| `CELL+` | `a-addr1 -- a-addr2` | Add cell size to adrs |
| `CHAR` | `-- char` | Parse ASCII character |
| `CHARS` | `n1 -- n2` | Chars->adrs units |
| `CHAR+` | `c-addr1 -- c-addr2` | Add char size to adrs |
| `COUNT` | `c-addr1 -- c-addr2 u` | Counted->adr/len |
| `CR` | `--` | Output newline |
| `CREATE` | `--` | Create an empty definition |
| `DECIMAL` | `--` | Set number base to decimal |
| `DEPTH` | `-- +n` | Number of items on stack |
| `DO` | `-- adrs L: -- 0` | Start of DO..LOOP |
| `DOES>` | `--` | Change action of latest def'n |
| `ELSE` | `adrs1 -- adrs2` | Branch for IF..ELSE |
| `ENVIRONMENT?` | `c-addr u -- false` | System query |
| `EVALUATE` | `i*x c-addr u -- j*x` | Interpret string |
| `FIND` | `c-addr -- c-addr 0` | If name not found |
| | `xt 1` | If immediate |
| | `xt -1` | If "normal" |
| `FM/MOD` | `d1 n1 -- n2 n3` | Floored signed division |
| `HERE` | `-- addr` | Returns dictionary pointer |
| `HOLD` | `char --` | Add char to output string |
| `IF` | `-- adrs` | Conditional forward branch |
| `IMMEDIATE` | `--` | Make last def'n immediate |
| `LEAVE` | `-- L: -- adrs` | Exit DO..LOOP |
| `LITERAL` | `x --` | Append numeric literal to dict |
| `LOOP` | `adrs -- L: 0 a1 a2 .. aN --` | |
| `MAX` | `n1 n2 -- n3` | Signed maximum |
| `MIN` | `n1 n2 -- n3` | Signed minimum |
| `MOD` | `n1 n2 -- n3` | Signed remainder |
| `MOVE` | `addr1 addr2 u --` | Smart move |
| `M*` | `n1 n2 -- d` | Signed 16*16->32 multiply |
| `POSTPONE` | `--` | Postpone compile action of word |
| `QUIT` | `-- R: i*x --` | Interpret from keyboard |
| `RECURSE` | `--` | Recurse current definition |
| `REPEAT` | `adrs1 adrs2 --` | Resolve WHILE loop |
| `SIGN` | `n --` | Add minus sign if n<0 |
| `SM/REM` | `d1 n1 -- n2 n3` | Symmetric signed division |
| `SOURCE` | `-- adr n` | Current input buffer |
| `SPACE` | `--` | Output a space |
| `SPACES` | `n --` | Output n spaces |
| `STATE` | `-- a-addr` | Holds compiler state |
| `S"` | `--` | Compile in-line string |
| `."` | `--` | Compile string to print |
| `S>D` | `n -- d` | Single -> double precision |
| `THEN` | `adrs --` | Resolve forward branch |
| `TYPE` | `c-addr +n --` | Type line to terminal |
| `UNTIL` | `adrs --` | Conditional backward branch |
| `U.` | `u --` | Display u unsigned |
| `.` | `n --` | Display n signed |
| `WHILE` | `-- adrs` | Branch for WHILE loop |
| `WORD` | `char -- c-addr n` | Parse word delim by char |
| `[` | `--` | Enter interpretive state |
| `[CHAR]` | `--` | Compile character literal |
| `[']` | `--` | Find word & compile as literal |
| `]` | `--` | Enter compiling state |

### ANS Forth Extensions

Optional words specified by the ANS Forth document.

| Word | Stack Effect | Description |
|------|--------------|-------------|
| `.S` | `--` | Print stack contents |
| `/STRING` | `a u n -- a+n u-n` | Trim string |
| `AGAIN` | `adrs --` | Uncond'l backward branch |
| `COMPILE,` | `xt --` | Append execution token |
| `DABS` | `d1 -- +d2` | Absolute value, dbl.prec. |
| `DNEGATE` | `d1 -- d2` | Negate, double precision |
| `HEX` | `--` | Set number base to hex |
| `PAD` | `-- a-addr` | User PAD buffer |
| `TIB` | `-- a-addr` | Terminal Input Buffer |
| `WITHIN` | `n1\|u1 n2\|u2 n3\|u3 -- f` | Test n2<=n1<n3? |
| `WORDS` | `--` | List all words in dict. |

### Private Extensions

Words unique to CamelForth.

| Word | Stack Effect | Description |
|------|--------------|-------------|
| `!CF` | `adrs cfa --` | Set code action of a word |
| `!COLON` | `--` | Change code field to docolon |
| `!DEST` | `dest adrs --` | Change a branch dest'n |
| `#INIT` | `-- n` | #bytes of user area init data |
| `'SOURCE` | `-- a-addr` | Two cells: len, adrs |
| `(DOES>)` | `--` | Run-time action of DOES> |
| `(S")` | `-- c-addr u` | Run-time code for S" |
| `,BRANCH` | `xt --` | Append a branch instruction |
| `,CF` | `adrs --` | Append a code field |
| `,DEST` | `dest --` | Append a branch address |
| `,EXIT` | `--` | Append hi-level EXIT action |
| `>COUNTED` | `src n dst --` | Copy to counted str |
| `>DIGIT` | `n -- c` | Convert to 0..9A..Z |
| `>L` | `x -- L: -- x` | Move to Leave stack |
| `?ABORT` | `f c-addr u --` | Abort & print msg |
| `?DNEGATE` | `d1 n -- d2` | Negate d1 if n negative |
| `?NEGATE` | `n1 n2 -- n3` | Negate n1 if n2 negative |
| `?NUMBER` | `c-addr -- n -1` | Convert string->number |
| | `-- c-addr 0` | If convert error |
| `?SIGN` | `adr n -- adr' n' f` | Get optional sign |
| `CELL` | `-- n` | Size of one cell |
| `COLD` | `--` | Cold start Forth system |
| `COMPILE` | `--` | Append inline execution token |
| `DIGIT?` | `c -- n -1` | If c is a valid digit |
| | `-- x 0` | Otherwise |
| `DP` | `-- a-addr` | Holds dictionary ptr |
| `ENDLOOP` | `adrs xt -- L: 0 a1 a2 .. aN --` | |
| `HIDE` | `--` | "hide" latest definition |
| `HP` | `-- a-addr` | HOLD pointer |
| `IMMED?` | `nfa -- f` | Fetch immediate flag |
| `INTERPRET` | `i*x c-addr u -- j*x` | Interpret given buffer |
| `L0` | `-- a-addr` | Bottom of Leave stack |
| `LATEST` | `-- a-addr` | Last word in dictionary |
| `LP` | `-- a-addr` | Leave-stack pointer |
| `L>` | `-- x L: x --` | Move from Leave stack |
| `NFA>CFA` | `nfa -- cfa` | Name adr -> code field |
| `NFA>LFA` | `nfa -- lfa` | Name adr -> link field |
| `R0` | `-- a-addr` | End of return stack |
| `REVEAL` | `--` | "reveal" latest definition |
| `S0` | `-- a-addr` | End of parameter stack |
| `TIBSIZE` | `-- n` | Size of TIB |
| `U0` | `-- a-addr` | Current user area adrs |
| `UD*` | `ud1 d2 -- ud3` | 32*16->32 multiply |
| `UD/MOD` | `ud1 u2 -- u3 ud4` | 32/16->32 divide |
| `UINIT` | `-- addr` | Initial values for user area |
| `UMAX` | `u1 u2 -- u` | Unsigned maximum |
| `UMIN` | `u1 u2 -- u` | Unsigned minimum |

# Forth Programming Examples

Here is the quintessential introduction to Forth, originating from the era of early 8-bit personal computers.

https://www.forth.com/starting-forth/

## 1. Basic Stack Manipulation

```forth
\ Example of basic stack operations
5 3 2    \ Put three numbers on the stack
.S       \ Print stack contents -- output: 5 3 2
DUP      \ Duplicate top number
.S       \ Stack now: 5 3 2 2
SWAP     \ Swap top two numbers
.S       \ Stack now: 5 3 2 2
DROP     \ Remove top number
.        \ Print top number
CR       \ Carriage return (newline)
```

## 2. Simple Calculator

```forth
\ Definition for squaring a number
: SQUARE ( n -- n^2 )
    DUP *
;

\ Definition for cube
: CUBE ( n -- n^3 )
    DUP SQUARE *
;

\ Example usage
5 SQUARE .  \ Outputs: 25
3 CUBE .    \ Outputs: 27

\ Basic arithmetic calculator
: CALCULATE ( n1 n2 -- )
    2DUP + ." Sum: " . CR
    2DUP - ." Difference: " . CR
    2DUP * ." Product: " . CR
    SWAP DUP 0= IF 
        DROP DROP ." Division by zero! " CR
    ELSE
        / ." Quotient: " . CR
    THEN
;

10 5 CALCULATE
```

## 3. String Handling

```forth
\ Print a string
: GREET ( -- )
    ." Hello, Forth Programmer!" CR
;

\ Count characters in a string
: COUNT-CHARS ( addr u -- n )
    0 DO
        1+
    LOOP
;

\ Example of string comparison
: SAME-STRING? ( addr1 u1 addr2 u2 -- flag )
    ROT SWAP                \ Reorder parameters
    S=                      \ Compare strings
    0=                      \ Convert to boolean
;
```

## 4. Simple Loop Examples

```forth
\ Print numbers from 1 to n
: COUNT-TO ( n -- )
    1+ 1 DO
        I .
        SPACE
    LOOP
    CR
;

\ Print a multiplication table
: TIMES-TABLE ( n -- )
    CR
    ." Multiplication table for " DUP . CR
    11 1 DO
        DUP I * .
        SPACE
    LOOP
    DROP
    CR
;

\ Example usage:
5 COUNT-TO      \ Prints: 1 2 3 4 5
7 TIMES-TABLE   \ Prints multiplication table for 7
```

## 5. Memory Operations

```forth
\ Create a variable
VARIABLE COUNT
0 COUNT !      \ Initialize to 0

\ Increment counter
: INC-COUNT ( -- )
    1 COUNT +!
;

\ Reset counter
: RESET-COUNT ( -- )
    0 COUNT !
;

\ Show counter
: SHOW-COUNT ( -- )
    ." Counter: "
    COUNT @ .
    CR
;

\ Example usage:
SHOW-COUNT     \ Shows: Counter: 0
INC-COUNT
INC-COUNT
SHOW-COUNT     \ Shows: Counter: 2
RESET-COUNT
SHOW-COUNT     \ Shows: Counter: 0
```

## 6. Simple Data Structure (Stack)

```forth
\ Implementation of a small stack (max 10 items)
CREATE STACK 10 CELLS ALLOT
VARIABLE STACK-PTR
0 STACK-PTR !

: STACK-PUSH ( n -- )
    STACK-PTR @ 9 > IF
        ." Stack overflow! " DROP
    ELSE
        STACK-PTR @ CELLS STACK + !
        1 STACK-PTR +!
    THEN
;

: STACK-POP ( -- n )
    STACK-PTR @ 0= IF
        ." Stack underflow! " 0
    ELSE
        -1 STACK-PTR +!
        STACK-PTR @ CELLS STACK + @
    THEN
;

\ Example usage:
5 STACK-PUSH
10 STACK-PUSH
STACK-POP .    \ Outputs: 10
STACK-POP .    \ Outputs: 5
```

## 7. Conditional Examples

```forth
\ Check if a number is positive, negative, or zero
: CHECK-NUMBER ( n -- )
    DUP 0= IF
        ." Number is zero" CR DROP
    ELSE
        DUP 0< IF
            ." Number is negative" CR DROP
        ELSE
            ." Number is positive" CR DROP
        THEN
    THEN
;

\ Example usage:
5 CHECK-NUMBER    \ Outputs: Number is positive
-3 CHECK-NUMBER   \ Outputs: Number is negative
0 CHECK-NUMBER    \ Outputs: Number is zero
```

These examples demonstrate basic Forth programming concepts including:

- Stack manipulation
- Arithmetic operations
- String handling
- Loops and iteration
- Memory operations
- Simple data structures
- Conditional statements

Each example includes comments explaining the operations and expected output. Remember that Forth is a stack-based language, so understanding stack manipulation is crucial for writing effective programs.