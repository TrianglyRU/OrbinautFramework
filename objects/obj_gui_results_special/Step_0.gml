switch state
{	
    case SPECIAL_RESULTS_STATE.LOAD:
	
        if --state_timer > 0
        {
            break;
        }
		
		// Fallthrough to SPECIAL_RESULTS_STATE.MOVE
        state_timer = 180;
        state = SPECIAL_RESULTS_STATE.MOVE;

    case SPECIAL_RESULTS_STATE.MOVE:
    case SPECIAL_RESULTS_STATE.WAIT_EXIT:
	
        offset_line1 = min(offset_line1 + speed_x, 0);
        offset_line2 = max(offset_line2 - speed_x, 0);
        offset_score = max(offset_score - speed_x, 0);
        offset_rings = max(offset_rings - speed_x, 0);
        
        if --state_timer > 0
        {
			break;
		}
		
        if state == SPECIAL_RESULTS_STATE.WAIT_EXIT
        {
			state = SPECIAL_RESULTS_STATE.EXIT;
			
            audio_sfx_play(snd_warp_enter);
            fade_perform_white(FADE_DIRECTION.OUT, 1, on_fade_start_return);
        }
		else
		{
			state = SPECIAL_RESULTS_STATE.TALLY;
		}
        		
    break;
	
    case SPECIAL_RESULTS_STATE.TALLY:
	
        if ring_bonus > 0
        {
			var _pressed = input_check_pressed(0);
			
			if _pressed.action1 || _pressed.action2 || _pressed.action3 || _pressed.start
			{
				global.score_count += ring_bonus * 100;
				total_score += ring_bonus * 100;
				ring_bonus = 0;
				
				break;
			}
			
            ring_bonus--;
            total_score += 100;
            global.score_count += 100;
			
            if obj_game.frame_counter % 4 == 0
            {
                audio_sfx_play(snd_beep);
            }
			
            break;
        }
        
        if global.emerald_count == 7
        {
			state_timer = 0;
            state = SPECIAL_RESULTS_STATE.SUPER_MSG;
        }
        else
        {
            state_timer = 120;
            state = SPECIAL_RESULTS_STATE.WAIT_EXIT;
        }
		
        audio_sfx_play(snd_tally);
		
    break;
	
    case SPECIAL_RESULTS_STATE.SUPER_MSG:
		
		if state_timer == 0
		{
			if audio_bgm_is_playing(0)
			{
				break;
			}
			
			audio_bgm_play(snd_bgm_all_emeralds);
		}
		
		state_timer = -1;
        offset_line1 = max(offset_line1 - speed_x * 2, SPECIAL_RESULTS_OFFSET_LINE_1);
        offset_line2 = min(offset_line2 + speed_x * 2, SPECIAL_RESULTS_OFFSET_LINE_2);
        
        if offset_line1 == SPECIAL_RESULTS_OFFSET_LINE_1 && offset_line2 == SPECIAL_RESULTS_OFFSET_LINE_2
        {
            message_super = true;
            state_timer = 180;
            state = SPECIAL_RESULTS_STATE.WAIT_EXIT;
        }
		
    break;
}