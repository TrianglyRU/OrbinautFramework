// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.PAUSE);

#macro BRIDGE_LERP_VALUE 0.25
#macro BRIDGE_ANGLE_INCREMENT 5.625 // is ANGLE_INCREMENT * 4

depth = draw_depth(40);
solid_balance = false;
log_size = sprite_get_width(sprite_index);
log_size_half = floor(log_size * 0.5);
log_amount = floor(sprite_width / log_size);
log_x = [];
log_y = [];
log_bend_value = [];
log_bend_offset = [];
log_index_by_player = array_create(PLAYER_MAX_COUNT, 1);
players_on = ds_list_create();
max_bend_log_number = 0;
max_bend_value = 0;
bend_angle = 0;

for (var _i = 0; _i < log_amount; _i++) 
{
	log_x[_i] = x - log_amount * log_size_half + log_size * _i + log_size_half
	log_y[_i] = y;
	log_bend_offset[_i] = 0;
	log_bend_value[_i] = _i < floor(log_amount * 0.5) ? (_i + 1) * 2 : (log_amount - _i) * 2;
}