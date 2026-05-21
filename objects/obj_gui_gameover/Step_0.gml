switch state
{
	case GAMEOVER_STATE.SLIDE_IN:
		
		offset_x = max(offset_x - speed_x, 0);
		
		if offset_x == 0
		{
			state = GAMEOVER_STATE.WAIT;
		}
		
	break;
	
	case GAMEOVER_STATE.WAIT:
		
		var _input_press = input_check_pressed(0);
		
		if _input_press.action1 || _input_press.action2 || _input_press.action3 || wait_timer == 0
		{
			state = GAMEOVER_STATE.EXIT;
			
			audio_bgm_stop(1);
			fade_perform_black(FADE_DIRECTION.OUT, 1, on_fade_continue_game);	
		}
		else
		{
			wait_timer--;
		}
			
	break;
}