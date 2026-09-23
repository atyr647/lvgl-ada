/* C side of the parts of the binding that LVGL exposes as macros, static
 * inline functions, or functions taking small structs by value -- none of
 * which Ada can import directly and safely.
 *
 * Conventions, so the Ada side never depends on C enum numbering:
 *   - colors are 0xRRGGBB integers,
 *   - opacity is 0..255,
 *   - enumerations are the small integers documented on each function and
 *     translated here. */
#include "lvgl/lvgl.h"
#include "lvgl/src/libs/tjpgd/tjpgd.h"
#include "lvgl/src/misc/cache/instance/lv_image_cache.h"
#include <stdlib.h>
#include <string.h>

/* ------------------------------------------------------------------ */
/* Style properties (local styles on one object)                      */
/* ------------------------------------------------------------------ */

void lvada_bg(lv_obj_t *o, uint32_t rgb, uint32_t opa, uint32_t sel)
{
    lv_obj_set_style_bg_color(o, lv_color_hex(rgb), sel);
    lv_obj_set_style_bg_opa(o, (lv_opa_t)opa, sel);
}

/* dir: 0 vertical (top to bottom), 1 horizontal (left to right) */
void lvada_bg_grad(lv_obj_t *o, uint32_t rgb, int dir, uint32_t sel)
{
    lv_obj_set_style_bg_grad_color(o, lv_color_hex(rgb), sel);
    lv_obj_set_style_bg_grad_dir(o, dir == 1 ? LV_GRAD_DIR_HOR : LV_GRAD_DIR_VER, sel);
}

void lvada_text(lv_obj_t *o, uint32_t rgb, uint32_t sel)
{
    lv_obj_set_style_text_color(o, lv_color_hex(rgb), sel);
}

void lvada_text_opa(lv_obj_t *o, uint32_t opa, uint32_t sel)
{
    lv_obj_set_style_text_opa(o, (lv_opa_t)opa, sel);
}

void lvada_font(lv_obj_t *o, const lv_font_t *f, uint32_t sel)
{
    lv_obj_set_style_text_font(o, f, sel);
}

/* align: 0 left, 1 center, 2 right */
void lvada_text_align(lv_obj_t *o, int align, uint32_t sel)
{
    lv_obj_set_style_text_align(o, align == 1 ? LV_TEXT_ALIGN_CENTER
                                   : align == 2 ? LV_TEXT_ALIGN_RIGHT
                                                : LV_TEXT_ALIGN_LEFT, sel);
}

void lvada_letter_space(lv_obj_t *o, int32_t px, uint32_t sel)
{
    lv_obj_set_style_text_letter_space(o, px, sel);
}

void lvada_line_space(lv_obj_t *o, int32_t px, uint32_t sel)
{
    lv_obj_set_style_text_line_space(o, px, sel);
}

void lvada_radius(lv_obj_t *o, int32_t r, uint32_t sel)
{
    lv_obj_set_style_radius(o, r, sel);
}

int32_t lvada_radius_circle(void) { return LV_RADIUS_CIRCLE; }

void lvada_clip_corner(lv_obj_t *o, int on, uint32_t sel)
{
    lv_obj_set_style_clip_corner(o, on != 0, sel);
}

/* sides: bit 0 bottom, 1 top, 2 left, 3 right (0 = none, 15 = full) */
void lvada_border(lv_obj_t *o, int32_t w, uint32_t rgb, uint32_t opa, int sides, uint32_t sel)
{
    lv_border_side_t s = LV_BORDER_SIDE_NONE;
    if (sides & 1) s |= LV_BORDER_SIDE_BOTTOM;
    if (sides & 2) s |= LV_BORDER_SIDE_TOP;
    if (sides & 4) s |= LV_BORDER_SIDE_LEFT;
    if (sides & 8) s |= LV_BORDER_SIDE_RIGHT;
    lv_obj_set_style_border_width(o, w, sel);
    lv_obj_set_style_border_color(o, lv_color_hex(rgb), sel);
    lv_obj_set_style_border_opa(o, (lv_opa_t)opa, sel);
    lv_obj_set_style_border_side(o, s, sel);
}

void lvada_outline(lv_obj_t *o, int32_t w, uint32_t rgb, uint32_t opa, int32_t pad, uint32_t sel)
{
    lv_obj_set_style_outline_width(o, w, sel);
    lv_obj_set_style_outline_color(o, lv_color_hex(rgb), sel);
    lv_obj_set_style_outline_opa(o, (lv_opa_t)opa, sel);
    lv_obj_set_style_outline_pad(o, pad, sel);
}

void lvada_pad(lv_obj_t *o, int32_t top, int32_t bottom, int32_t left, int32_t right, uint32_t sel)
{
    lv_obj_set_style_pad_top(o, top, sel);
    lv_obj_set_style_pad_bottom(o, bottom, sel);
    lv_obj_set_style_pad_left(o, left, sel);
    lv_obj_set_style_pad_right(o, right, sel);
}

void lvada_gap(lv_obj_t *o, int32_t row, int32_t column, uint32_t sel)
{
    lv_obj_set_style_pad_row(o, row, sel);
    lv_obj_set_style_pad_column(o, column, sel);
}

void lvada_shadow(lv_obj_t *o, int32_t w, uint32_t rgb, uint32_t opa,
                  int32_t ofs_y, int32_t spread, uint32_t sel)
{
    lv_obj_set_style_shadow_width(o, w, sel);
    lv_obj_set_style_shadow_color(o, lv_color_hex(rgb), sel);
    lv_obj_set_style_shadow_opa(o, (lv_opa_t)opa, sel);
    lv_obj_set_style_shadow_offset_y(o, ofs_y, sel);
    lv_obj_set_style_shadow_spread(o, spread, sel);
}

void lvada_opa(lv_obj_t *o, uint32_t opa, uint32_t sel)
{
    lv_obj_set_style_opa(o, (lv_opa_t)opa, sel);
}

void lvada_image_recolor(lv_obj_t *o, uint32_t rgb, uint32_t opa, uint32_t sel)
{
    lv_obj_set_style_image_recolor(o, lv_color_hex(rgb), sel);
    lv_obj_set_style_image_recolor_opa(o, (lv_opa_t)opa, sel);
}

/* Arcs: the spinner's track (part MAIN) and indicator (part INDICATOR). */
void lvada_arc(lv_obj_t *o, int32_t w, uint32_t rgb, uint32_t opa, uint32_t sel)
{
    lv_obj_set_style_arc_width(o, w, sel);
    lv_obj_set_style_arc_color(o, lv_color_hex(rgb), sel);
    lv_obj_set_style_arc_opa(o, (lv_opa_t)opa, sel);
    lv_obj_set_style_arc_rounded(o, true, sel);
}

void lvada_min_height(lv_obj_t *o, int32_t h, uint32_t sel) { lv_obj_set_style_min_height(o, h, sel); }
void lvada_max_width(lv_obj_t *o, int32_t w, uint32_t sel)  { lv_obj_set_style_max_width(o, w, sel); }

/* A short fade on state changes (e.g. pressed) for a softer feel. */
void lvada_transition_ms(lv_obj_t *o, uint32_t ms, uint32_t sel)
{
    static const lv_style_prop_t props[] = {
        LV_STYLE_BG_COLOR, LV_STYLE_BG_OPA, LV_STYLE_TRANSFORM_WIDTH,
        LV_STYLE_TRANSFORM_HEIGHT, LV_STYLE_TEXT_COLOR, 0 };
    /* one descriptor per duration; a handful of durations are used */
    static lv_style_transition_dsc_t cache[8];
    static uint32_t cached_ms[8];
    static int n = 0;
    lv_style_transition_dsc_t *d = NULL;
    for (int i = 0; i < n; i++)
        if (cached_ms[i] == ms) d = &cache[i];
    if (!d) {
        if (n == 8) return;
        d = &cache[n];
        cached_ms[n++] = ms;
        lv_style_transition_dsc_init(d, props, lv_anim_path_ease_out, ms, 0, NULL);
    }
    lv_obj_set_style_transition(o, d, sel);
}

/* Shrink slightly while pressed: tactile feedback without any image. */
void lvada_press_shrink(lv_obj_t *o, int32_t px)
{
    lv_obj_set_style_transform_width(o, -px, LV_STATE_PRESSED);
    lv_obj_set_style_transform_height(o, -px, LV_STATE_PRESSED);
}

/* ------------------------------------------------------------------ */
/* Sizes and layout                                                   */
/* ------------------------------------------------------------------ */

int32_t lvada_pct(int32_t v) { return LV_PCT(v); }
int32_t lvada_size_content(void) { return LV_SIZE_CONTENT; }

/* flow: 0 row, 1 column, 2 row with wrapping, 3 column with wrapping
 * align values: 0 start, 1 end, 2 center, 3 space evenly,
 *               4 space around, 5 space between */
static lv_flex_align_t flex_align(int a)
{
    switch (a) {
    case 1: return LV_FLEX_ALIGN_END;
    case 2: return LV_FLEX_ALIGN_CENTER;
    case 3: return LV_FLEX_ALIGN_SPACE_EVENLY;
    case 4: return LV_FLEX_ALIGN_SPACE_AROUND;
    case 5: return LV_FLEX_ALIGN_SPACE_BETWEEN;
    default: return LV_FLEX_ALIGN_START;
    }
}

void lvada_flex(lv_obj_t *o, int flow, int main_align, int cross_align, int track_align)
{
    static const lv_flex_flow_t flows[] = {
        LV_FLEX_FLOW_ROW, LV_FLEX_FLOW_COLUMN, LV_FLEX_FLOW_ROW_WRAP, LV_FLEX_FLOW_COLUMN_WRAP };
    lv_obj_set_flex_flow(o, flows[flow & 3]);
    lv_obj_set_flex_align(o, flex_align(main_align), flex_align(cross_align),
                          flex_align(track_align));
}

/* mode: 0 off, 1 on, 2 active (while scrolling), 3 auto */
void lvada_scrollbar(lv_obj_t *o, int mode)
{
    static const lv_scrollbar_mode_t m[] = {
        LV_SCROLLBAR_MODE_OFF, LV_SCROLLBAR_MODE_ON, LV_SCROLLBAR_MODE_ACTIVE, LV_SCROLLBAR_MODE_AUTO };
    lv_obj_set_scrollbar_mode(o, m[mode & 3]);
}

/* dir: 0 none, 1 vertical, 2 horizontal, 3 both */
void lvada_scroll_dir(lv_obj_t *o, int dir)
{
    static const lv_dir_t d[] = { LV_DIR_NONE, LV_DIR_VER, LV_DIR_HOR, LV_DIR_ALL };
    lv_obj_set_scroll_dir(o, d[dir & 3]);
}

void lvada_scroll_to_y(lv_obj_t *o, int32_t y, int anim)
{
    lv_obj_scroll_to_y(o, y, anim ? LV_ANIM_ON : LV_ANIM_OFF);
}

/* Remove the default theme's styling entirely: a blank container. */
void lvada_plain(lv_obj_t *o)
{
    lv_obj_remove_style_all(o);
    lv_obj_set_scrollable(o, false);
}

/* ------------------------------------------------------------------ */
/* Fonts                                                              */
/* ------------------------------------------------------------------ */

lv_font_t *lvada_ttf(const void *data, size_t len, int32_t px)
{
    return lv_tiny_ttf_create_data(data, len, px);
}

void lvada_ttf_destroy(lv_font_t *f) { lv_tiny_ttf_destroy(f); }

/* Glyphs missing from f (e.g. icons) are looked up in fallback. */
void lvada_font_fallback(lv_font_t *f, const lv_font_t *fallback) { f->fallback = fallback; }

int32_t lvada_font_line_height(const lv_font_t *f) { return lv_font_get_line_height(f); }

const lv_font_t *lvada_builtin_font(int px)
{
    switch (px) {
#if LV_FONT_MONTSERRAT_16
    case 16: return &lv_font_montserrat_16;
#endif
#if LV_FONT_MONTSERRAT_20
    case 20: return &lv_font_montserrat_20;
#endif
#if LV_FONT_MONTSERRAT_24
    case 24: return &lv_font_montserrat_24;
#endif
#if LV_FONT_MONTSERRAT_28
    case 28: return &lv_font_montserrat_28;
#endif
    default: return &lv_font_montserrat_14;
    }
}

/* ------------------------------------------------------------------ */
/* Frames: in-memory XRGB8888 images for camera video and snapshots   */
/* ------------------------------------------------------------------ */

lv_image_dsc_t *lvada_frame_new(int32_t w, int32_t h)
{
    lv_image_dsc_t *d;
    if (w <= 0 || h <= 0)
        return NULL;
    d = calloc(1, sizeof *d);
    if (!d)
        return NULL;
    d->header.magic = LV_IMAGE_HEADER_MAGIC;
    d->header.cf = LV_COLOR_FORMAT_XRGB8888;
    d->header.w = (uint32_t)w;
    d->header.h = (uint32_t)h;
    d->header.stride = (uint32_t)w * 4;
    d->data_size = (uint32_t)w * (uint32_t)h * 4;
    d->data = calloc(1, d->data_size);
    if (!d->data) {
        free(d);
        return NULL;
    }
    return d;
}

void lvada_frame_free(lv_image_dsc_t *d)
{
    if (!d)
        return;
    lv_image_cache_drop(d);
    free((void *)d->data);
    free(d);
}

uint8_t *lvada_frame_pixels(lv_image_dsc_t *d) { return (uint8_t *)d->data; }
int32_t lvada_frame_width(const lv_image_dsc_t *d) { return (int32_t)d->header.w; }
int32_t lvada_frame_height(const lv_image_dsc_t *d) { return (int32_t)d->header.h; }

/* After the pixels changed: make the image widget redraw them. */
void lvada_frame_changed(lv_obj_t *img, lv_image_dsc_t *d)
{
    lv_image_cache_drop(d);
    lv_obj_invalidate(img);
}

/* mode: 0 as is (centered), 1 contain (fit inside, keep aspect),
 *       2 cover (fill, crop, keep aspect), 3 stretch */
void lvada_image_fit(lv_obj_t *img, int mode)
{
    static const lv_image_align_t m[] = {
        LV_IMAGE_ALIGN_CENTER, LV_IMAGE_ALIGN_CONTAIN, LV_IMAGE_ALIGN_COVER, LV_IMAGE_ALIGN_STRETCH };
    lv_image_set_inner_align(img, m[mode & 3]);
}

/* JPEG -> frame (tjpgd), shrunk by an integer factor so the result fits
 * in max_w x max_h: a 2560x1920 camera snapshot shown on a phone never
 * needs all its pixels in memory at once. NULL if not a baseline JPEG. */
struct jsrc {
    const uint8_t *data;
    size_t len, pos;
    lv_image_dsc_t *out;
    int shrink;
};

static size_t jpeg_in(JDEC *jd, uint8_t *buf, size_t n)
{
    struct jsrc *s = jd->device;
    size_t left = s->len - s->pos;
    if (n > left)
        n = left;
    if (buf)
        memcpy(buf, s->data + s->pos, n);
    s->pos += n;
    return n;
}

static int jpeg_out(JDEC *jd, void *bitmap, JRECT *r)
{
    struct jsrc *s = jd->device;
    const uint8_t *px = bitmap;   /* RGB888 (JD_FORMAT 0) */
    int k = s->shrink;
    int32_t ow = (int32_t)s->out->header.w, oh = (int32_t)s->out->header.h;
    uint8_t *dst = (uint8_t *)s->out->data;
    for (int y = r->top; y <= r->bottom; y++) {
        for (int x = r->left; x <= r->right; x++, px += 3) {
            if (y % k || x % k)
                continue;
            int32_t ox = x / k, oy = y / k;
            if (ox >= ow || oy >= oh)
                continue;
            uint8_t *p = dst + ((size_t)oy * ow + ox) * 4;
            p[0] = px[2];   /* B */
            p[1] = px[1];   /* G */
            p[2] = px[0];   /* R */
            p[3] = 0xFF;
        }
    }
    return 1;
}

lv_image_dsc_t *lvada_jpeg_decode(const uint8_t *data, size_t len, int32_t max_w, int32_t max_h)
{
    JDEC jd;
    struct jsrc s = { data, len, 0, NULL, 1 };
    void *pool = malloc(32768);
    lv_image_dsc_t *out = NULL;

    if (!pool)
        return NULL;
    if (jd_prepare(&jd, jpeg_in, pool, 32768, &s) != JDR_OK)
        goto done;
    while ((max_w > 0 && (int32_t)jd.width / s.shrink > max_w)
           || (max_h > 0 && (int32_t)jd.height / s.shrink > max_h))
        s.shrink++;
    out = lvada_frame_new((int32_t)(jd.width + s.shrink - 1) / s.shrink,
                          (int32_t)(jd.height + s.shrink - 1) / s.shrink);
    if (!out)
        goto done;
    s.out = out;
    if (jd_decomp(&jd, jpeg_out, 0) != JDR_OK) {
        lvada_frame_free(out);
        out = NULL;
    }
done:
    free(pool);
    return out;
}

/* ------------------------------------------------------------------ */
/* Misc                                                               */
/* ------------------------------------------------------------------ */

void lvada_fade_in(lv_obj_t *o, uint32_t ms, uint32_t delay) { lv_obj_fade_in(o, ms, delay); }

void lvada_bar_value(lv_obj_t *bar, int32_t v, int anim)
{
    lv_bar_set_value(bar, v, anim ? LV_ANIM_ON : LV_ANIM_OFF);
}

/* mode: 0 lower-case text, 1 numbers */
void lvada_keyboard_mode(lv_obj_t *kb, int mode)
{
    lv_keyboard_set_mode(kb, mode == 1 ? LV_KEYBOARD_MODE_NUMBER : LV_KEYBOARD_MODE_TEXT_LOWER);
}

uint32_t lvada_state_pressed(void) { return LV_STATE_PRESSED; }
uint32_t lvada_state_checked(void) { return LV_STATE_CHECKED; }
uint32_t lvada_state_disabled(void) { return LV_STATE_DISABLED; }
uint32_t lvada_state_focused(void) { return LV_STATE_FOCUSED; }
uint32_t lvada_part_indicator(void) { return LV_PART_INDICATOR; }
uint32_t lvada_part_items(void) { return LV_PART_ITEMS; }
uint32_t lvada_part_scrollbar(void) { return LV_PART_SCROLLBAR; }
uint32_t lvada_part_knob(void) { return LV_PART_KNOB; }
uint32_t lvada_part_cursor(void) { return LV_PART_CURSOR; }

void lvada_move_foreground(lv_obj_t *o) { lv_obj_move_foreground(o); }
