// Inherit the parent event
event_inherited();

depth = RENDER_DEPTH_OVERLAY;
max_allowed_game_state = GAME_STATE.STOP_ALL;
timer = 0;
offset_zone = 288;
offset_zonename = 256;
offset_act = 320;
offset_banner = -224;
speed_x = 16;
speed_y = 16;

if global.stage_transition_data == undefined
{
	fade_perform_black(FADE_DIRECTION.OUT, 0);
}