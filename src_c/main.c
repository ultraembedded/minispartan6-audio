#include <stdint.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

#include "spi.h"
#include "sd.h"

#include "fat_filelib.h"

#include "timer.h"
#include "serial.h"
#include "mp3.h"
#include "audio.h"
#include "printf.h"

//-----------------------------------------------------------------
// Defines:
//-----------------------------------------------------------------
#define SD_CTRL_BASE        0x93000000

#define AUDIO_BASE          0x96000000
#define IRQ_AUDIO_FIFO      5

//-----------------------------------------------------------------
// mp3_poll
//-----------------------------------------------------------------
static void mp3_poll(int samples)
{
    static t_time sampleTime = 0;
    static unsigned int sampleCount = 0;

    int ch = serial_getchar();
    if (ch == 'S')
        mp3_stop();

    sampleCount += samples;
    if (timer_diff(timer_now(), sampleTime) >= 1000)
    {
        printf("%d\n", sampleCount);
        sampleCount = 0;
        sampleTime = timer_now();
    }    
}
//-----------------------------------------------------------------
// play_dir
//-----------------------------------------------------------------
static void play_dir(const char *path)
{
    FL_DIR dir;
    FL_FILE *file;
    fl_dirent direntry;
    char filename[FATFS_MAX_LONG_FILENAME];
    char ext[3+1];  

    if (fl_opendir(path, &dir))
    {
        while (fl_readdir(&dir, &direntry) >= 0)
        {
            if (!direntry.is_dir && fatfs_get_extension(direntry.filename, ext, sizeof(ext)))
                if (strcmp(ext, "mp3") == 0)
                {
                    fatfs_create_path_string(path, direntry.filename, filename, sizeof(filename));

                    printf("Playing '%s'..\n", filename);
                    mp3_play(filename, mp3_poll);
                    printf("Done..\n");
                }
        }
    }   
}
//-----------------------------------------------------------------
// main
//-----------------------------------------------------------------
int main(int argc, char *argv[])
{
    printf("SD Test\n");

    spi_init(SD_CTRL_BASE, 0);
    if (sd_init() < 0)
    {
        printf("ERROR: Cannot init SD card\n");
        return -1;
    }

    // Initialise File IO Library
    fl_init();

    // Attach media access functions to library
    if (fl_attach_media(sd_readsector, sd_writesector) != FAT_INIT_OK)
    {
        printf("ERROR: Failed to init file system\n");
        return -1;
    }
   
    // List a directory
    fl_listdirectory("/");

    // Initialise mp3 codec
    mp3_init();

    audio_init(AUDIO_BASE, IRQ_AUDIO_FIFO, CPU_KHZ * 1000, AUDIO_TARGET_ANALOG);
    play_dir("/");

    return 0;
}
