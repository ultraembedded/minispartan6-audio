#ifndef __AUDIO_BUFFER_H__
#define __AUDIO_BUFFER_H__

#include <stdint.h>
#include "list.h"

//-----------------------------------------------------------------
// Defines:
//-----------------------------------------------------------------
#ifndef AUDIO_BUFFER_ENTRY_SIZE
#define AUDIO_BUFFER_ENTRY_SIZE     (2304)
#endif
#ifndef AUDIO_BUFFER_ENTRIES
#define AUDIO_BUFFER_ENTRIES        (30)
#endif

//-----------------------------------------------------------------
// Types:
//-----------------------------------------------------------------
struct audiobuf
{
    struct link_node    list_entry;
    int16_t             audio[AUDIO_BUFFER_ENTRY_SIZE];
    int16_t *           ptr;
    uint32_t            size;
    int                 is_le;
    void*               handle;
};

//-----------------------------------------------------------------
// Prototypes:
//-----------------------------------------------------------------
void                audiobuf_init(void);
struct audiobuf*    audiobuf_alloc(void);
void                audiobuf_free(struct audiobuf *buf);

#endif // __AUDIO_BUFFER_H__
