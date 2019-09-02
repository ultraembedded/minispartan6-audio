#ifndef __AUDIO_H__
#define __AUDIO_H__

#include "audio_buffer.h"

typedef enum 
{
	AUDIO_TARGET_I2S,
	AUDIO_TARGET_SPDIF,
	AUDIO_TARGET_ANALOG,
	AUDIO_TARGET_MAX
} tAudioTarget;

//-----------------------------------------------------------------
// Prototypes:
//-----------------------------------------------------------------
void audio_init(uint32_t base_addr, int irq_num, uint32_t clock_rate, tAudioTarget target);
void audio_queue_buffer(struct audiobuf *buf);
void audio_swap_channels(int enable);
void audio_swap_endian(int enable);
void audio_set_volume(int percent);

#endif // __AUDIO_H__
