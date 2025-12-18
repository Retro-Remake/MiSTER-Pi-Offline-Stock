Tatung Einstein for MiSTer FPGA
===============================

This is the port of the Tatung Einstein TC01 & 256 for MiSTer FPGA by Pierco (Pierre Cornier).


Insert a DSK file then press CTRL+TAB to load it. Use the `DIR` command to list the files if it's not a bootable disk. If you want to run a COM file, just type the name without the extension and press the [ENTER] key. For XBS basic files, you will need to load the XBasic first (insert the disk and type `XBAS`), then load your XBS file with `LOAD "filename"` and type `RUN`.

Thank you guys!
---------------

I want to thank Stan Hodge and Alan Steremberg for their help!
And I would also like to thank Fabrizio Di Vittorio for allowing me to include his diagnostic ROM with the core. You can enable it in OSD.

https://github.com/fdivitto/TatungEinsteinDiagnosticFirmware


Not implemented
---------------

The diagnostic ROM will fail at the floppy disc controller.

- PIO connected to port M001 for printer.
- PCI for serial communication.

Games, Software and information
-------------------------------

- http://www.tatungeinstein.co.uk/
- http://tatungeinstein.hopto.org/8-bit/Tatung%20Einstein/

