if c_framework.fade.state == FADESTATE.PLAINCOLOUR
{	
	// We got a time over, restart the stage
	if frame_number == 1
	{
		if array_length(global.checkpoint_data) > 0
		{
			global.checkpoint_data[2] = 0;
		}
			
		game_clear_temp_data(false);
		room_restart();
			
		exit;
	}
		
	// We've ran out of lives, restart the game (or go to the Continue screen)
	global.life_count = 3;
	global.score_count = 0;
		
	game_save_data(global.current_save_slot);
	
	if global.continue_count > 0
	{
		game_clear_temp_data(true);
		room_goto(rm_continue);
	}	
	else
	{
		room_goto(room_first);
	}
}
	
switch state
{
	case GAMEOVER_STATE_SLIDE_IN:
			
		offset_x = max(offset_x - speed_x, 0);
		
		if offset_x == 0
		{
			state = GAMEOVER_STATE_WAIT;
		}
		
	break;
		
	case GAMEOVER_STATE_WAIT:
			
		if input_get_pressed(0).action_any || wait_timer == 0
		{
			state++;
				
			audio_stop_bgm(0.5);
			fade_perform_black(FADEROUTINE.OUT, 1);	
			
			break;
		}
	
		wait_timer--;
			
	break;
}