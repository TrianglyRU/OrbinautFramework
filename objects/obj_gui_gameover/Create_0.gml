obj_game.allow_pause = false;

// Inherit the parent event
event_inherited();

enum GAMEOVER_STATE
{
	SLIDE_IN,
	WAIT,
	EXIT
}

on_fade_continue_game = function()
{
	if audio_bgm_is_playing()
	{
		return false;
	}
				
	if image_index == 1
	{
		var _checkpoint_data = global.checkpoint_data;			
			
		if array_length(_checkpoint_data) > 0
		{
			_checkpoint_data[2] = 0;
		}
		
		game_clear_level_data();
		room_restart();
	}
	else
	{
		global.life_count = 3;
		global.score_count = 0;
			
		game_clear_level_data_all();
		game_save_data(global.current_save_slot);
		
		if global.continue_count > 0
		{
			room_goto(rm_continue);
		}
		else
		{
			room_goto(global.start_room);
		}
	}
				
	return true;
}

depth = RENDER_DEPTH_HUD;
image_index = global.life_count > 0 && FRAME_COUNTER >= 36000;
max_allowed_game_state = GAME_STATE.STOP_OBJECTS;
state = GAMEOVER_STATE.SLIDE_IN;
wait_timer = 720;
offset_x = 208;
speed_x = 16;

audio_bgm_play(snd_bgm_game_over);