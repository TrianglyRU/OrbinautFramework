switch state
{	
	// Originals take some time (~40 frames) to load Results Screen object,
	// so we add an artificial delay by implementing this states
    case SS_RESULTS_STATE_LOAD:
	
        if --state_timer > 0
        {
            break;
        }
		
		// Fallthrough to SS_RESULTS_STATE_MOVE
        state_timer = 180;
        state = SS_RESULTS_STATE_MOVE;

    case SS_RESULTS_STATE_MOVE:
    case SS_RESULTS_STATE_WAIT_EXIT:
	
        // Update offsets and manage state transition
        offset_line1 = min(offset_line1 + speed_x, 0);
        offset_line2 = max(offset_line2 - speed_x, 0);
        offset_score = max(offset_score - speed_x, 0);
        offset_rings = max(offset_rings - speed_x, 0);
        
        if --state_timer == 0
        {
            if state == SS_RESULTS_STATE_WAIT_EXIT
            {
                audio_play_sfx(sfx_warp);
                fade_perform_white(FADEROUTINE.OUT, 1);
            }
			
            state++;
        }
		
    break;

    case SS_RESULTS_STATE_TALLY:
	
        // Process ring bonus and update state based on emerald count
        if ring_bonus > 0
        {
            ring_bonus--;
            total_score += 100;
            global.score_count += 100;
			
            if c_framework.frame_counter % 4 == 0
            {
                audio_play_sfx(sfx_beep);
            }
			
            exit;
        }
        
        if global.emerald_count == 7
        {
            state = SS_RESULTS_STATE_SUPERMSG;
        }
        else
        {
            state_timer = 120;
            state = SS_RESULTS_STATE_WAIT_EXIT;
        }
		
        audio_play_sfx(sfx_tally);
		
    break;

    case SS_RESULTS_STATE_SUPERMSG:
	
        // Show super message and then wait to exit
        offset_line1 = max(offset_line1 - speed_x * 2, -288);
        offset_line2 = min(offset_line2 + speed_x * 2, 288);
        
        if offset_line1 == -288 && offset_line2 == 288
        {
            message_super = true;
            state_timer = 180;
            state = SS_RESULTS_STATE_WAIT_EXIT;
        }
		
    break;

    case SS_RESULTS_STATE_EXIT:
	
        // Handle fade out and room transition
        if c_framework.fade.state != FADESTATE.PLAINCOLOUR
        {
            break;
        }
		
        if visible
        {
			visible = false;
            fade_perform_black(FADEROUTINE.OUT, 1);      
            break;
        }
		
        if !audio_is_playing(sfx_warp)
        {
            room_goto(global.previous_room_id);
        }
		
    break;
}