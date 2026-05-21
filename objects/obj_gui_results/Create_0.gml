obj_rm_stage.bgm_track = undefined;
obj_game.allow_pause = false;

// Inherit the parent event
event_inherited();

enum RESULTS_STATE
{
	LOAD,
	MOVE_IN,
	TALLY,
	POST_TALLY,
	MOVE_OUT,
	EXIT
}

on_fade_load_next_room = function()
{
	if audio_bgm_is_playing()
	{
		return false;
	}
	
	var _next_room = obj_rm_stage.next_stage;
		
	if _next_room == undefined
	{
		room_restart();
	}
	else
	{
		room_goto(_next_room);
	}
	
	game_clear_level_data_all();
	
	return true;
}

depth = RENDER_DEPTH_HUD;
continue_timer = -1;
offset_line1 = -256;
offset_line2 = 256;
offset_time = 512;
offset_rings = 528;
offset_perfect = 544;
offset_total = 560;
speed_x = 16;
state = RESULTS_STATE.LOAD;
state_timer = 40;
total_bonus = 0;
ring_bonus = global.player_rings * 100;
player = player_get(0);

audio_bgm_play(snd_bgm_act_clear);

var _stage_time = obj_gui_hud.local_timer;

if _stage_time < 1800			// < 0:30
{
	time_bonus = 50000;
}
else if _stage_time < 2700		// < 0:45
{
	time_bonus = 10000;
}
else if _stage_time < 3600		// < 1:00
{
	time_bonus = 5000;
}
else if _stage_time < 5400		// < 1:30
{
	time_bonus = 4000;
}
else if _stage_time < 7200		// < 2:00
{
	time_bonus = 3000;
}
else if _stage_time < 10800		// < 3:00
{
	time_bonus = 2000;
}
else if _stage_time < 14400		// < 4:00
{
	time_bonus = 1000;
}
else if _stage_time < 18000		// < 5:00
{
	time_bonus = 500;
}
else							// >= 5:00
{
	time_bonus = 0;
}