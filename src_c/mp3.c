#ifdef INCLUDE_MP3_SUPPORT
#include "assert.h"
#include "mp3dec.h"
#include "audio.h"
#include "audio_buffer.h"

#define USE_FILELIB_STDIO_COMPAT_NAMES
#include "fat_filelib.h"

//-----------------------------------------------------------------
// Defines:
//-----------------------------------------------------------------
// Should be at least 1 frame at high bitrate
#define READ_CHUNK_SIZE             (128 * 1024)
#define BUFFER_SIZE                 (READ_CHUNK_SIZE + MAINBUF_SIZE)

//-----------------------------------------------------------------
// Locals:
//-----------------------------------------------------------------
static uint8_t readBuf[BUFFER_SIZE + 32];
static HMP3Decoder hMP3Decoder;
static volatile int _stop = 0;

//-----------------------------------------------------------------
// FillReadBuffer:
//-----------------------------------------------------------------
static int FillReadBuffer(uint8_t *readBuf, uint8_t **readPtr, int bytesLeft, void *file)
{
    int nRead;
    int nRequest = READ_CHUNK_SIZE;

    uint8_t *target = readBuf;

    // Non-word aligned amount of data will be read
    if (bytesLeft & 3)
    {
        int offset = bytesLeft & 3;
        int align_count = 4 - offset;
        
        target += align_count;
    }

    // move last, small chunk from end of buffer to start, then fill with new data
    memmove(target, *readPtr, bytesLeft);

    nRead = fread(target + bytesLeft, 1, nRequest, file);

    // zero-pad to avoid finding false sync word after last frame (from old data in readBuf)
    if (nRead < nRequest)
        memset(target + bytesLeft + nRead, 0, nRequest - nRead);

    *readPtr = target;

    return nRead;
}
//-----------------------------------------------------------------
// mp3_init:
//-----------------------------------------------------------------
int mp3_init(void)
{
    // Allocate mp3 decoder buffers
    if ( (hMP3Decoder = MP3InitDecoder()) == 0 )
    {
        printf("MP3: Error allocating decoder\n");
        return -1;
    }

    // Check audio buffers area large enough
    assert((MAX_NCHAN * MAX_NGRAN * MAX_NSAMP) <= AUDIO_BUFFER_ENTRY_SIZE);    
    return 0;
}
//-----------------------------------------------------------------
// mp3_play:
//-----------------------------------------------------------------
int mp3_play(const char *filename, void (*poll)(int samples))
{
    int bytesLeft, err, offset, outOfData, eofReached;    
    FILE *file;    
    MP3FrameInfo mp3FrameInfo;
    uint8_t *readPtr;
    struct audiobuf* aud_buf;

    assert(hMP3Decoder);

    // Try and open file first
    file = fopen(filename, "rb");
    if (!file) 
    {
        printf("MP3: Could not open %s\n", filename);
        return -1;
    }

    memset(readBuf, 0x00, sizeof(readBuf));

    bytesLeft = 0;
    outOfData = 0;
    eofReached = 0;
    readPtr = readBuf;
    do 
    {
        // Refill required
        if (bytesLeft < MAINBUF_SIZE && !eofReached) 
        {
            int nRead = FillReadBuffer(readBuf, &readPtr, bytesLeft, file);
            bytesLeft += nRead;
            if (nRead == 0)
                eofReached = 1;
        }

        // Find start of next MP3 frame - assume EOF if no sync found
        offset = MP3FindSyncWord(readPtr, bytesLeft);
        if (offset < 0) 
        {
            outOfData = 1;
            break;
        }
        readPtr += offset;
        bytesLeft -= offset;

        // Wait for audio buffer
        do
        {
            aud_buf = audiobuf_alloc();
        }
        while (!aud_buf);

        // Play frame (decode one MP3 frame)
        err = MP3Decode(hMP3Decoder, &readPtr, &bytesLeft, aud_buf->audio, 0);
        if (err) 
        {
            switch (err) 
            {
            case ERR_MP3_INDATA_UNDERFLOW:
                printf("ERR_MP3_INDATA_UNDERFLOW\n");
                outOfData = 1;
                break;
            case ERR_MP3_MAINDATA_UNDERFLOW:
                /* do nothing - next call to decode will provide more mainData */
                break;
            case ERR_MP3_FREE_BITRATE_SYNC:
            default:
                printf("ERR_MP3_FREE_BITRATE_SYNC %d\n", err);
                outOfData = 1;
                break;
            }
        } 
        else
        {
            MP3GetLastFrameInfo(hMP3Decoder, &mp3FrameInfo);

            aud_buf->size = mp3FrameInfo.outputSamps / 2;
            assert(aud_buf->size > 0 && aud_buf->size < 10000);

            // Queue audio buffer
            audio_queue_buffer(aud_buf);

            // Periodic poll function supplied
            if (poll)
                poll(mp3FrameInfo.outputSamps / 2);

            if (_stop)
                break;
        }
    } 
    while (!outOfData);

    // Close file
    fclose(file);

    _stop = 0;

    return 0;
}
//-----------------------------------------------------------------
// mp3_stop:
//-----------------------------------------------------------------
int mp3_stop(void)
{
    _stop = 1;
    return 0;
}

#endif