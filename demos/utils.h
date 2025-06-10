#include <stdint.h>

/* Converts a8r8g8b8 pixels to pixels that
 *  - are not premultiplied,
 *  - are stored in this order in memory: R, G, B, A, regardless of
 *    the endianness of the computer.
 * It is allowed for @src and @dst to point to the same memory buffer.
 */
void
a8r8g8b8_to_rgba_np (uint32_t *dst, uint32_t *src, int n_pixels)
{
    uint8_t *dst8 = (uint8_t *)dst;
    int i;

    for (i = 0; i < n_pixels; ++i)
    {
	uint32_t p = src[i];
	uint8_t a, r, g, b;

	a = (p & 0xff000000) >> 24;
	r = (p & 0x00ff0000) >> 16;
	g = (p & 0x0000ff00) >> 8;
	b = (p & 0x000000ff) >> 0;

	if (a != 0)
	{
#define DIVIDE(c, a)							\
	    do								\
	    {								\
		int t = ((c) * 255) / a;				\
		(c) = t < 0? 0 : t > 255? 255 : t;			\
	    } while (0)

	    DIVIDE (r, a);
	    DIVIDE (g, a);
	    DIVIDE (b, a);
	}

	*dst8++ = r;
	*dst8++ = g;
	*dst8++ = b;
	*dst8++ = a;
    }
}