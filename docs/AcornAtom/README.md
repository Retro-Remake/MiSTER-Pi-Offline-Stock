# Acorn_Atom_MiSTer

Acorn Atom for MiSTer FPGA

## Introduction
This is a cut down version of the fabulous [AtomFPGA by David Banks (Hoglet)](https://github.com/hoglet67/AtomFpga) and my thanks to him for his help.

The [Acorn Atom](https://en.wikipedia.org/wiki/Acorn_Atom) was the predecessor of the BBC micro based on Acorn's System computers. It was available as a kit or ready made. The Acorn had 2KB of RAM that was expandable to 12KB and 8KB of ROM that was expandable to 16KB. It could display graphics in monochrome at a resolution of 256x192 pixels, although later a colour board was made.

## Features
* 32KB ram
* System Roms with mmc (to access the SD card)
* Seven additional Roms and 1 slot of ram to download additional Rom.
* Two character sets.
* Tape in/out (not tested)
* Selectable sound, Atom,SID,Tape,off
* Black or Dark background
* Atom or BBC Basic mode
* Colour palette
* SID sound
* Turbo mode (f1,f2,f3,f4)
* Four keyboards - UK(default),USA,original,game

## Controls
UK/US Keyboards - Shift lock is Caps, Repeat is right Alt, copy is tab - Left Alt is xtra shift key. 

The original keyboard had @ and up-arrow as separate keys these have moved to a PS2 config. 

Up-Arrow is shift+6 so to "shift" this press left Alt+shift+6. 

The original keyboard is as originally written ie shift+8 = ( and shift+9 = )

The game keyboard just reverses the ctrl and shift as on the original keyboard, for games like Asteroids. 

## Instructions
You need a boot.vhd file formatted as FAT and around 100MB. There is a blank.zip in releases. Unzip and rename to boot.vhd

Attach the boot.vhd and copy software onto it.

Detach the VHD and place the file in the games/AcornAtom folder on your SD card. 

To auto boot the software menu Shift-Break(f10), Ctrl-Break disables the MMC Rom

The best software source is the AtomSoftwareArchive V11 zip 11.9MB

There are several sites dedicated to the atom.
