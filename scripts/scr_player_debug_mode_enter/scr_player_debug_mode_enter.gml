/// @self obj_player
function scr_player_debug_mode_enter()
{
	if player_index > 0 || !global.dev_mode && !global.enable_debug_mode
	{
	    return false;
	}
	
	if state == PLAYER_STATE.DEATH && death_state != DEATH_STATE.WAIT
	{
		return false;
	}
	
	if input_press.action2
	{
		reset_substate();
		state = PLAYER_STATE.DEBUG_MODE;
		on_object = noone;
		image_alpha = 1;
		visible = true;
		depth = base_depth;
	    
		if view_data_ref.index == player_index
		{
			view_data_ref.allow_updates = true;
		}
		
		if obj_game.state == GAME_STATE.STOP_OBJECTS
	    {
	        obj_game.state = GAME_STATE.NORMAL;
			obj_game.allow_pause = true;
			
			// The framework has already processed state changes by this point. Since we change obj_game.state 
			// manually here, stopped objects need to be reactivated manually as well
			obj_game.restore_stopped_objects();
	    }
		
		if !audio_bgm_is_playing() || audio_is_playing(snd_bgm_drowning)
		{
			if instance_exists(obj_rm_stage)
			{
				restart_bgm(obj_rm_stage.bgm_track);
			}
		}
	    
		// Exit the player control routine
	    return true;
	}

	return false;
}