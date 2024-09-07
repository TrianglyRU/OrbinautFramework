/// @function scr_player_debug_mode_enter
function scr_player_debug_mode_enter()
{
	// Check if player can enter Debug Mode
	if player_index > 0 || !global.dev_mode && !global.enable_debug_mode
	{
	    return false;
	}
	
	if state == PLAYER_STATE_DEATH && death_state != DEATH_STATE_WAIT
	{
		return false;
	}
	
	// Determine if debug button is pressed
	var _debug_button = input_press.action2;

	if global.dev_mode
	{
	    _debug_button = keyboard_check_pressed(vk_space);
		
	    var _pads_array = c_framework.input.pads_array;
		
	    if array_length(_pads_array) > 0
	    {
	        _debug_button |= gamepad_button_check_pressed(_pads_array[0], gp_face3);
	    }
	}

	// Activate Debug Mode if the button is pressed
	if _debug_button
	{
		visible = true;
		image_alpha = 1.0;
	    state = PLAYER_STATE_DEBUG_MODE;
		camera_data.allow_movement = true;
		
		obj_reset_priority();
		
		// Due to certain culling implementation limitations, we reactivate everything back here,
		// not when the player leaves the Debug Mode
		if c_framework.state == STATE_STOP_OBJECTS
	    {
	        c_framework.state = STATE_NORMAL;
	    }
		
	    if audio_is_playing(bgm_drowning) || !audio_bgm_is_playing()
	    {
	        audio_reset_bgm(c_stage.bgm_track, id);
	    }
		
		// Exit the player control routine
	    return true;
	}

	return false;
}
