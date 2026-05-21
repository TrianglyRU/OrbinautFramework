var _x = camera_get_width(view_current) * 0.5 + 72;
var _y = camera_get_height(view_current) * 0.5 + 77;

draw_sprite(spr_level_select_icon, icon_to_draw == undefined ? 0 : icon_to_draw, _x, _y);
draw_sprite(sprite_index, 0, _x, _y);