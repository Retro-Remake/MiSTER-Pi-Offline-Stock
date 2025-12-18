# BK0011M for [MiSTer Board](https://github.com/MiSTer-devel/Main_MiSTer/wiki)

This project of [popular USSR home computer](https://en.wikipedia.org/wiki/Electronika_BK) is based on precise [KR1801VM1](http://zx-pk.ru/showthread.php?t=23978) Verilog model by Vslav

### Features:
- Fully functional BK0011M and BK0010 with close to real CPU and Video timings (need furter corrections)
- Turbo mode (6MHz for BK0010, 8MHz for BK0011M)
- Raw DSK image support (read-only, Disk A)
- Multipatitioned VHD image (read-write, Disk C+)
- BIN file support for BK0010 mode (only single file apps are supported)
- A16M extension for BK0010 (support for short and long resets)
- SMK512 extension for BK0011M
- YM2149 with 1.71MHz clock
- Joystick
- Mouse

No contention model is used in turbo mode, thus speed is higher more than twice.

### Installation:
Copy the *.rbf file at the root of the SD card.

There are couple disk images in [extra](https://github.com/MiSTer-devel/BK0011M_MiSTer/tree/master/extra) folder with CSIDOS OS with complete ecosystem (viewer,text editor, music editor, debugger, etc.) written by me more than 20 years ago. Image also incudes some music and utils written by different people.

*Most documents are in Russian languange.*

### HDD Utility
Supplied [HDD Utility](https://github.com/MiSTer-devel/BK0011M_MiSTer/tree/master/SW/bkhdutil.exe) can be used to concatenate separate DSK image into one VHD image. You can put it to root of SD card. If you will name it as bk0011m.vhd then it will autoload at start.

Press F12 to access OSD menu.

##### Keyboard map:

| PC key      |  BK Key       |
|:-----------:|:-------------:|
| ESC         | KT            |
| F1          | ПОВТ          |
| F2          | ВС            |
| F3          | ГРАФ          |
| F4          | Color/Mono    |
| F5          | -!->          |
| F6          | ИНДСУ         |
| F7          | БЛОК РЕД      |
| F8          | ШАГ           |
| F9          | СБР           |
| F10         | СТОП          |
| RCtrl+F11   | RESET         |
| F11         | Change colors |
| F12         | OSD Menu      |
| Insert      | !-->          |
| Delete      | !<--          |
| Shift+Enter | УСТ ТАБ       |
| Shift+Tab   | СБР ТАБ       |
| Alt+Tab     | ШАГ ПО ТАБ    |
| Left Win    | ЛАТ           |
| Left Ctrl   | РУС           |
| Right Ctrl  | УС (Ctrl)     |
| Alt         | АР2 (Alt)     |

### Additional info:
ROM contains debugger which can be launched by following commands from Monitor:
- **13;1C**
- **100000G**

if disk support in OSD is turned off, then diagnostic utility can be launched by following command from Monitor:
- **160000G**

### Download precompiled binaries:
Go to [releases](https://github.com/MiSTer-devel/BK0011M_MiSTer/tree/master/releases) folder.
