// Inherit the parent event
event_inherited();

x = camera_get_width(0) * 0.5 + 72;
y = camera_get_height(0) * 0.5 + 77;

icon_map = ds_map_create();
icon_to_draw = 0;

scr_level_select_icon_setup();