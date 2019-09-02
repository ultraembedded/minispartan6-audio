TARGET       = sd_mp3
ARCH         = riscv
PLATFORM     = machine-fpga

EXTRA_CFLAGS+= -DCPU_KHZ=50000

SRC_DIR      = ./ 
SRC_DIR     += ./include

# SD card
SRC_DIR      += ./drivers/spi/ ./drivers/sd/
EXTRA_CFLAGS += -DINCLUDE_SD_DRIVER -DINCLUDE_SPI_LITE_IP_DRIVER

# MP3 Codec
EXTRA_CFLAGS+= -DINCLUDE_MP3_SUPPORT
SRC_DIR     += ./lib/libhelix-mp3/real
SRC_DIR     += ./lib/libhelix-mp3/pub
SRC_DIR     += ./lib/libhelix-mp3

# FAT filesystem
SRC_DIR     += ./lib/fat_io_lib/src

# Malloc support
EXTRA_CFLAGS+= -DCONFIG_MALLOC
EXTRA_CFLAGS+= -DCONFIG_MALLOC_SIZE=131072

# UART driver
EXTRA_CFLAGS += -DCONFIG_UARTLITE
EXTRA_CFLAGS += -DCONFIG_UARTLITE_BASE=0x92000000
SRC_DIR     += ./drivers/uart

# Audio
SRC_DIR     += ./drivers/audio

# IRQ driver
EXTRA_CFLAGS+= -DCONFIG_IRQCTRL
EXTRA_CFLAGS+= -DCONFIG_IRQCTRL_BASE=0x90000000
SRC_DIR     += ./drivers/irq

MEM_SIZE     ?= 1048576

OPT           = 2

TARGET_PORT ?= /dev/ttyUSB2
RUN_PREFIX  := ../run.py -d $(TARGET_PORT) -b 1000000 -f 

MAKE_DIR=./make
include $(MAKE_DIR)/makefile.exe
