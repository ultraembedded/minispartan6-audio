# miniSpartan6+ (Spartan6) FPGA based MP3 Player

Github:   [https://github.com/ultraembedded/minispartan6-audio](https://github.com/ultraembedded/minispartan6-audio)

An audio player (MP3) based on the Scarab Hardware miniSpartan6+ FPGA board featuring my RISC-V CPU, SDRAM controller and peripherals.

## Cloning
```
# Clone repository and submodules
git clone https://github.com/ultraembedded/minispartan6-audio.git --recursive
```

## Features
* 50MHz RISC-V (RV32IM) CPU with ICACHE (2-way x 8KB), DCACHE (2-way x 8KB write-back).
* AXI4 infrastructure.
* SDRAM controller.
* SPI (SD card) interface.
* 2-ch audio controller (sigma delta DAC).
* UART -> AXI debug bridge (for loading code, etc).

## Details

I originally created a FPGA soft-CPU based MP3 player around a MIPS derivative in 2012 ([Hackaday](https://hackaday.com/2012/03/13/playing-mp3s-from-an-fpga/))

This time, I've rebuilt it around my RISC-V (RV32IM) CPU, SDRAM controller and SoC peripherals;

| Component | Description   |
| ---- | ------------- |
| [audio](https://github.com/ultraembedded/core_audio) | Audio Controller and FIFO |
| [core_soc](https://github.com/ultraembedded/core_soc) | SoC peripherals (timer, SPI, GPIO, UART) |
| [dbg_bridge](https://github.com/ultraembedded/core_dbg_bridge) | UART -> AXI debug bridge |
| [riscv](https://github.com/ultraembedded/riscv) | RISC-V (RV32IM) |
| [sdram](https://github.com/ultraembedded/core_sdram_axi4) | AXI4 SDRAM Controller |

The application code will play any MP3s found on a FAT32 formatted SD card placed in the microSD card slot of the FPGA dev board.

## Scarab Hardware miniSpartan6+
![](doc/minispartan6.jpg)

