Matra-Hachette Alice MC-10 for MiSTer FPGA
==========================================

This is the port of the Alice 4K / Tandy MC-10 to MiSTer FPGA.

Cassettes
---------

To facilitate the use of the cassette player, an option to display the data stream on the screen is available form the OSD.

The core is compatible with .c10 tape files. A small script `k72c10.py` is available for converting .k7 files from Alice into .c10 files. The script adds the two leader sections before and after the name block.

Usage: `python k72c10.py <path to k7 file>`.

You will end up with a new file named k7.c10, which should be compatible with the core.

Joystick
--------

While the Alice 4k was sold with a DB9 adapter cartridge, the MC10 has no official support for joysticks. A article published in SoftGold magazine shows how to build a simple two directional joystick connected on the RS-232 connector. The two joystick interfaces have been implemented in the core.

To do
-----

Many games/programs already work, however, there's currently a bug in the video module that prevents some games from changing the display mode. Other MiSTer contributors and I are working on the problem right now.
