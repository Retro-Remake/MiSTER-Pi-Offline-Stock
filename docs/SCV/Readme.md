# [Epoch Super Cassette Vision](https://en.wikipedia.org/wiki/Super_Cassette_Vision) core for [MISTer Platform](https://github.com/MiSTer-devel/Main_MiSTer/wiki)

This is an emulator of the Epoch Super Cassette Vision.

## Development status

### Phase 1 (done)

The best documentation I could find is embodied in the [MAME](https://www.mamedev.org) SCV emulator. Takeda-san's [eSCV](http://takeda-toshiya.my.coocan.jp/scv/index.html) and related documents were also very helpful. NEC data sheets of the uCOM-87 microcontroller series were found around the 'net and provided instruction opcodes, cycle timings and other details. The gaps (and there are many) were filled with educated guesses and prior art from building emulators for MOS6502-based machines and the SNES.

The audio processor (NEC uPD1771C-017) was reverse-engineered from a die shot, a transistor-level [JavaScript simulator](http://reverendgumby.gitlab.io/visuald1771c) of the same, and the [original LSI design docs](https://oura.oguchi-rd.com). The processor is actually a specialized 8-bit CPU with internal RAM and ROM. The -017 mask ROM is required.

### Phase 2 (current)

A Japanese console has been acquired. It is currently being examined (nicely) and its detailed behavior documented.

#### Epoch TV-1 video processor (done)

I have completed my deep dive into reverse-engineering the Epoch TV-1.  Numerous test ROMs were written to measure timing, explore corner cases and unusual behaviors, and understand observed differences from actual HW behavior.  Findings were detailed in 'doc/epochtv1.txt' and then used to refine the core.

I'm positive that I have figured out how rendering happens internally.  The core now produces VRAM (sprite pattern) bus address patterns that match those measured on actual HW.  Graphical glitches seen in some games are also reproduced with high accuracy: for example, portions of sprites drop out when the CPU accesses VRAM during sprite rendering.

All known display issues are now resolved.


## Features
- Cycle-accurate CPU (NEC uPD7801G)
- Logic-accurate audio processor (NEC uPD1771C)
- Behaviorally-accurate video processor (Epoch TV-1 (NTSC))
- Cartridge mapper support for all known released cartridges

## Installation
- Copy the latest *.rbf from releases/ to the root of the SD card
- Build boot.rom (see below)
- Create a folder on the SD card named "SCV" and copy boot.rom to it

### How to build boot.rom
Acquire these three files:
- upd7801g.s01 (MD5 sum 635a978fd40db9a18ee44eff449fc126)
- epochtv.chr.s02 (MD5 sum 929617bc739e58e550fe9025cae4158b)
- upd1771c-017.s03 (MD5 sum 9b03b66c6dc89de9a11d5cd908538ac3)

Concatenate the files to create boot.rom. Windows example:

`COPY /B upd7801g.s01 +epochtv.chr upd1771c-017.s03 boot.rom`

Note: upd1771c-017.s03 is in little-endian order (ROM low byte first).


## Usage

### Keyboard
The console has a numeric keypad called **SELECT**, and a hard **PAUSE** button.

* 0-9 - SELECT numbered keys
* Backspace, numpad ./Del - SELECT **CL** key
* Enter - SELECT **EN** key
* F1 - PAUSE button

### Joysticks
Up to two digital joysticks are mapped to the two controllers. Each controller has two **Trig** buttons.

The most common **SELECT** buttons -- 1 to 4 and **EN** -- can also be configured as joystick buttons.

Most games refer to a **START** button. This means to press both **Trig** buttons.

### Cartridge ROMs

ROM images must:
- Have a file extension .ROM or .BIN
- Be strictly the ROM contents (no headers)

Cartridges had 8K - 128K of ROM, and some had RAM. Two heuristics are used to identify the cartridge -- ROM size and checksum -- and map the memories appropriately. The OSD has an option to manually select a mapper.

#### Special cases
Two cartridges had a mix of ROM sizes. No special mappers exist for them (yet). Create a 64K .BIN file for them as follows:

##### Kung Fu Road
32K ROM + (first 24K [24,576 bytes] of 32K ROM) + 8K ROM --> 64K .BIN

##### Star Speeder
32K ROM + (first 24K [24,576 bytes] of 32K ROM) + 8K ROM --> 64K .BIN


## Known issues


## TODOs
- Audio (uPD1771C)
  - Actual HW is lot more "buzzy" at low volumes. Bug or feature?
- Cartridges
  - Save and restore battery-backed RAM
  - Make mappers for special cases
