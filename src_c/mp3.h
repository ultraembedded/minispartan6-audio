#ifndef __MP3_H__
#define __MP3_H__

//-----------------------------------------------------------------
// Prototypes:
//-----------------------------------------------------------------
int mp3_init(void);
int mp3_play(const char *filename, void (*poll)(int samples));
int mp3_stop(void);

#endif // __MP3_H__
