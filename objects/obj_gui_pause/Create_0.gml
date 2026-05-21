obj_game.state = GAME_STATE.STOP_ALL;

// Inherit the parent event
event_inherited();

enum PAUSE_STATE
{
	NAVIGATION,
	RESTART,
	EXIT
}

on_fade_handle_option = function()
{
	if audio_is_playing(snd_star_post)
	{
		return false;
	}
	
	if state == PAUSE_STATE.RESTART
	{
		global.life_count--;
		
		game_clear_level_data();
		room_restart();
	}
	else
	{
		game_clear_level_data_all();
		room_goto(rm_dev_menu);	
	}
	
	return true;
}

depth = RENDER_DEPTH_HUD_PRIORITY;
max_allowed_game_state = GAME_STATE.STOP_ALL;
state = PAUSE_STATE.NAVIGATION;
highlight_timer = -1;
option_id = 0;

audio_pause_all();
audio_sfx_play(snd_bumper);