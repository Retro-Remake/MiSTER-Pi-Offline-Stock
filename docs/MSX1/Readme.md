# MSX1 for [MiSTer Board](https://github.com/MiSTer-devel/Main_MiSTer/wiki)

## Features
- reference HW Philips VG8020/00
- RAM 64kB in slot 3
- Sound YM2149(PSG)
- Support two cartridges
- Automatic detect cartrige mapper. (Gamemaster2, Konami, Konami SCC, ASCII8, ASCII16, Linear64k) 
- Manual select mapper (R-TYPE)
- Joystick.
- FDD support (VY0010). Use DSK image
- Cassette support. Analog or CAS emulation
- PAL/NTSC mode
- Load bios for experimets

## Memory limitations
- No SDRAM 
  - Slot 1 only FDD or Gamemaster2 SRAM
  - Slot 2 ROM image max size 256kB
  - Slot 3 64Kb RAM
- 32MB SDRAM - 128MB SDRAM
  - Slot 1 ROM image max size 4MB
  - Slot 2 ROM image max size 4MB
  - Slot 3 64Kb RAM
  
## Custom ROM BIOS
Copy boot.rom to Games/MSX1 folder

## ALternative firmware/hangul ROM
Copy boot1.rom to Games/MSX1 folder
