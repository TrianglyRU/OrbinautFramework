// Called in c_framework -> Begin Step
var _input = input_get_pressed(0);

switch state
{
	case PAUSE_STATE_NAVIGATION:
	
		highlight_timer = (highlight_timer + 1) % 16;
		
		var _option_id = option_id;
		
		if _input.down && option_id < 2
		{
			option_id++;
		}
		else if _input.up && option_id > 0
		{
			option_id--;
		}

		if option_id != _option_id
		{
			audio_play_sfx(sfx_beep);
		}

		if !_input.action_any && !_input.start
		{
			break;
		}
		
		if option_id == 0
		{
			// We should reset the input now to not let the player read it	
			input_reset(_input);	
			
			c_framework.state = STATE_NORMAL;
			audio_resume_all();
			instance_destroy();
			audio_play_sfx(sfx_starpost);
			
			break;
		}
		
		if option_id == 1
		{	
			// Object culling is processed after the pause screen, so we can do this check
			if player_get(0).state == PLAYER_STATE_DEATH
			{
				audio_play_sfx(sfx_fail);
				break;
			}
				
			state = PAUSE_STATE_RESTART;
		}
		else
		{
			state = PAUSE_STATE_EXIT;
		}
		
		audio_play_sfx(sfx_starpost);
		fade_perform_black(FADEROUTINE.OUT, 1);
		
	break;

	case PAUSE_STATE_RESTART:
	case PAUSE_STATE_EXIT:
	
		if c_framework.fade.state != FADESTATE.PLAINCOLOUR || audio_is_playing(sfx_starpost)
		{
			break;
		}	
		
		if state == PAUSE_STATE_RESTART
		{
			// Do not run full clear, so we can restart from the latest checkpoint
			game_clear_temp_data(false);
			room_restart();
		}
		else
		{
			game_clear_temp_data();
			room_goto(rm_devmenu);
		}
		
	break;
}