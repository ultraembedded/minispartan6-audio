#include "irq.h"
#include "timer.h"
#include "assert.h"
#include "audio_buffer.h"

//-----------------------------------------------------------------
// Locals:
//-----------------------------------------------------------------
static struct audiobuf      _buffers[AUDIO_BUFFER_ENTRIES];
static struct link_list     _buffer_list;

//-----------------------------------------------------------------
// audiobuf_init
//-----------------------------------------------------------------
void audiobuf_init(void)
{
    int i;

    // Init buffer list
    list_init(&_buffer_list);

    // Add buffers to free list
    for (i=0;i<AUDIO_BUFFER_ENTRIES;i++)
        list_insert_last(&_buffer_list, &_buffers[i].list_entry);
}
//-----------------------------------------------------------------
// audiobuf_alloc
//-----------------------------------------------------------------
struct audiobuf* audiobuf_alloc(void)
{
    struct audiobuf* buf;
    struct link_node *node;
    int cr;

    if (list_is_empty(&_buffer_list))
        return 0;

    cr = irq_critical_start();

    // Get the first buffer
    node = list_first(&_buffer_list);
    buf = list_entry(node, struct audiobuf, list_entry);

    // Remove from the free list
    list_remove(&_buffer_list, &buf->list_entry);

    irq_critical_end(cr);

    // Reset details
    buf->is_le = 0;
    buf->size  = 0;
    buf->ptr   = buf->audio;

    return buf;
}
//-----------------------------------------------------------------
// audiobuf_free
//-----------------------------------------------------------------
void audiobuf_free(struct audiobuf *buf)
{
    int cr = irq_critical_start();

    assert(buf);
    list_insert_last(&_buffer_list, &buf->list_entry);

    irq_critical_end(cr);
}
