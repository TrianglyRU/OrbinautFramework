switch state
{
	// Originals take some time (~40 frames) to load Results Screen object,
	// so we add an artificial delay by implementing this states
    case RESULTS_STATE_LOAD:
	
        if --state_timer > 0
        {
            break;
        }
		
		// Fallthrough to RESULTS_STATE_MOVE
        state_timer = 180;
        state++;
	
	// loc_1419C
    case RESULTS_STATE_MOVE:
    case RESULTS_STATE_WAIT_EXIT:
	
        // Handle results movement and timing
        if state == RESULTS_STATE_MOVE
        {
            offset_line1 = min(offset_line1 + speed_x, 0);
            offset_line2 = max(offset_line2 - speed_x, 0);
            offset_time = max(offset_time - speed_x, 0);
            offset_rings = max(offset_rings - speed_x, 0);
            offset_perfect = max(offset_perfect - speed_x, 0);
            offset_total = max(offset_total - speed_x, 0);
        }
		
        if --state_timer != 0
        {
            break;
        }
		
        if state == RESULTS_STATE_WAIT_EXIT
        {
            if c_stage.save_progress
            {
                game_save_data(global.current_save_slot);
            }
            fade_perform_black(FADEROUTINE.OUT, 1);
        }
		
        state++;
		
    break;
	
	// loc_141AA
    case RESULTS_STATE_TALLY:
	
        // Update bonuses and check for state transition
        if time_bonus > 0 || ring_bonus > 0
        {
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
			
            if c_framework.frame_counter % 4 == 0
            {
                audio_play_sfx(sfx_beep);
            }
			
            break;
        }
		
        state = RESULTS_STATE_WAIT_EXIT;
		
        if total_bonus >= 10000
        {
            state_timer = 300;
            global.continue_count++;
            instance_create(0, 0, obj_continue_icon, { visible: false });    
        }
        else
        {
            state_timer = 180;
        }
		
        audio_play_sfx(sfx_tally);
		
    break;
    
	// loc_14270 and onwards
    case RESULTS_STATE_EXIT:
	
        // Transition to next stage
        if c_framework.fade.state != FADESTATE.PLAINCOLOUR
        {
            break;
        }
		
        game_clear_temp_data();
		
        if c_stage.next_stage == -1
        {
            room_restart();
        }
        else
        {
            room_goto(c_stage.next_stage);
        }
		
    break;
}