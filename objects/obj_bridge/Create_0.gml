// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.PAUSE);

#macro BRIDGE_LERP_VALUE 0.25
#macro BRIDGE_ANGLE_INCREMENT 5.625 // is ANGLE_INCREMENT * 4

depth = draw_depth(40);
solid_balance = false;

plank_width = sprite_get_width(sprite_index);
plank_width_half = floor(plank_width * 0.5);
plank_count = floor(sprite_width / plank_width);

plank_x = [];
plank_y = [];
plank_max_sag = []; 
plank_sag_offset = [];

player_plank_index = array_create(PLAYER_MAX_COUNT, 1);
players_on_bridge = ds_list_create();

peak_sag_plank_index = 0;
peak_sag_value = 0;
sag_angle = 0;

for (var _i = 0; _i < plank_count; _i++) 
{
	plank_x[_i] = x - plank_count * plank_width_half + plank_width * _i + plank_width_half;
	plank_y[_i] = y;
	plank_sag_offset[_i] = 0;
	plank_max_sag[_i] = _i < floor(plank_count * 0.5) ? (_i + 1) * 2 : (plank_count - _i) * 2;
}