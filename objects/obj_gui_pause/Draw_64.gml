var _w = display_get_gui_width()
var _h = display_get_gui_height();

var _dx = _w * 0.5;
var _dy = _h * 0.5;

shader_set(sh_rgb_fade);
draw_sprite(sprite_index, 0, _dx, _dy);

if highlight_timer < 8
{
    draw_sprite(spr_gui_pause_selection, option_id, _dx - 3, _dy - 7 + 16 * option_id);
}

shader_reset();