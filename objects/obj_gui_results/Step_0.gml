switch state
{
    case RESULTS_STATE.LOAD:
	
        if --state_timer > 0
        {
            break;
        }
		
		// Fallthrough to RESULTS_STATE.MOVE_IN
        state_timer = 180;
        state = RESULTS_STATE.MOVE_IN;
	
    case RESULTS_STATE.MOVE_IN:
	case RESULTS_STATE.MOVE_OUT:
	
		offset_line1 = min(offset_line1 + speed_x, 0);
        offset_line2 = max(offset_line2 - speed_x, 0);
        offset_time = max(offset_time - speed_x, 0);
        offset_rings = max(offset_rings - speed_x, 0);
        offset_perfect = max(offset_perfect - speed_x, 0);
        offset_total = max(offset_total - speed_x, 0);
		
		if state == RESULTS_STATE.MOVE_IN
		{
			if --state_timer == 0
			{
				state = RESULTS_STATE.TALLY;
			}	
		}
		else if offset_total >= 560
		{
			obj_game.clear_vram_on_room_end = false;
			obj_transition_save.save_data();
			
			on_fade_load_next_room();
		}
		
	break;
	
    case RESULTS_STATE.TALLY:
	
        if time_bonus > 0 || ring_bonus > 0
        {
			var _pressed = input_check_pressed(0);
			
			if _pressed.action1 || _pressed.action2 || _pressed.action3 || _pressed.start
			{
				global.score_count += time_bonus;
				global.score_count += ring_bonus;
				
				total_bonus += time_bonus;
				total_bonus += ring_bonus;
				time_bonus = 0;
				ring_bonus = 0;
				
				break;
			}
			
            if time_bonus > 0
            {
                time_bonus -= 100;
                total_bonus += 100;
                global.score_count += 100;
            }
			
            if ring_bonus > 0
            {
                ring_bonus -= 100;
                total_bonus += 100;
                global.score_count += 100;
            }
			
            if FRAME_COUNTER % 4 == 0
            {
                audio_sfx_play(snd_beep);
            }
			
            break;
        }
		
		state = RESULTS_STATE.POST_TALLY;
		
        if total_bonus >= 10000
        {
			continue_timer = 0;
            state_timer = 300;
            global.continue_count++;  
        }
        else
        {
            state_timer = 180;
        }
		
        audio_sfx_play(snd_tally);
		
    break;
	
	case RESULTS_STATE.POST_TALLY:
	
		if continue_timer >= 0
		{
			if ++continue_timer == 60
			{
				audio_sfx_play(snd_continue);
			}
		}
		
        if --state_timer != 0
        {
            break;
        }
		
        if obj_rm_stage.progress_flag > 0
        {
			if global.game_progress_flag < GAME_PROGRESS_MAX
			{
				global.game_progress_flag = obj_rm_stage.progress_flag;
			}
			
            game_save_data(global.current_save_slot);
        }
		
		if instance_exists(obj_transition_save)
		{
			state = RESULTS_STATE.MOVE_OUT;
			speed_x *= -2;
		}
		else
		{
			state = RESULTS_STATE.EXIT;
			fade_perform_black(FADE_DIRECTION.OUT, 1, on_fade_load_next_room);
		}
		
    break;
}