# BBC Bridge Companion for [MiSTer](https://github.com/MiSTer-devel/Main_MiSTer/wiki)

An FPGA implementation of the BBC Bridge Companion - a console designed solely to teach the game of bridge!

## Credits
- [__JimmyStones__](https://github.com/JimmyStones): Core design and implementation
- [__Heber Ltd__](http://www.heber.co.uk/): Original designer and manufacturer of the BBC Bridge Companion!
- [__Arnim Laeuger__](arnim.laeuger@gmx.net): VDP18 module (TMS9129-compatible video processor), Verilog conversion by [__Frank Bruno__](fbruno@asicsolutions.com)
- [__NibblesLab__](https://github.com/NibblesLab): z8420 module (partial Z80 PIO support)

## FPGA implementation
- Built entirely in simulation using original schematics and information from MAME, logic has been simplified where possible
- Functionally verified against a real BBC Bridge Companion (Bridge Builder cartridge only)
- All firmware and official cartridge ROMs are built-in with permission of Heber Ltd, no additional files required

## Software
This core supports all official software cartridges:
- Advanced Bidding
- Advanced Defence
- Bridge Builder
- Club Play 1
- Club Play 2
- Club Play 3
- Conventions 1
- Duplicate 1
- Master Play 1

Use the 'Cartridge' option in the OSD to select an official cartridge.

To load unofficial software set the 'Cartridge' option to 'Empty' and use the 'Load custom cartridge' option.

## Controls
| Action | Keyboard | Joypad default |
| --- | --- | --- |
| Pass | A | X |
| NT | S | Y |
| Dbl | D | A |
| Rdbl | F | B |
| Spades | Z | Left |
| Hearts / Up | X | Up |
| Diamonds / Down | C | Down |
| Clubs | V | Right |
| Start | 1 | R |
| Back | Backspace | L |
| Play / Yes | Left Control | Z |
| Play / No | Left Alt | C |

## History

The BBC Bridge Companion system was designed and created by Heber Ltd. The original hardware developer was Bob Powell (the owner of Heber Ltd. when it was set up in 1984).

It was the first product Heber developed, started in 1983 during the final days of Marion Electronics (Heber's predecessor at the same site), then completed as Heber Ltd. in 1984.

A licencing deal was negotiated with BBC Enterprises Ltd. to use the logo by Tony Reynolds (another of the original founders of Heber). Tony also had the industrial design of the enclosure commissioned and made as Heber's first injection mould tooling, quite a risk and cost for a start-up with its first product in 1984.

The electronics, cartridges and embedded firmware were also all developed by Heber Ltd at the time.

## Known issues / to-do
- The 2nd menu option is selected on game load, instead of the 1st.  Possibly an issue with the Z80 PIO implementation?
- If the Forced Scandoubler INI option is active then a reset / game load on FPGA will occasionally cause graphical oddities.  Reset/re-load until the issue goes away!

## Original schematic
![BBC_BRIDGE_Original_Schematic_1984_A](/resources/BBC_BRIDGE_Original_Schematic_1984_A.png "Original BBC Bridge schematic")

## License
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
