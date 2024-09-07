/// @function scr_player_dash
function scr_player_dash()
{
	gml_pragma("forceinline");
	
	if !global.dash || PlayerType != PLAYER_SONIC || player_index > 0 && cpu_timer_input == 0
	{
	    exit;
	}
	
	// Dash initiation logic
	if action != ACTION_DASH
	{    
	    if action == ACTION_NONE && animation == ANI_LOOKUP && input_down.up && input_press.action_any
	    {
	        animation = ANI_MOVE;
	        action = ACTION_DASH;
	        dash_charge = 0;
	        dash_vel = 0;
	        audio_play_sfx(sfx_charge2, [1.00, 2.30]);
	    }
	    else
	    {
	        return false;    
	    }
	}

	// Charge Dash and update velocity
	var _increment_value = 0.390625;
	var _speed_cap = (item_speed_timer > 0 || super_timer > 0) ? acc_top * 1.5 : acc_top * 2;

	if input_down.up
	{
	    if dash_charge < PARAM_DASH_CHARGE
	    {
	        dash_charge++;
	    }
		
	    dash_vel = min(dash_vel + _increment_value, _speed_cap);
	    spd_ground = dash_vel * facing;
		
	    return false;
	}

	audio_stop_sound(sfx_charge2);
	action = ACTION_NONE;

	// Release Dash or reset if not fully charged
	if dash_charge == PARAM_DASH_CHARGE
	{
		// There is no camera delay for Dash in CD, so we assume it uses the same logic as the Spin Dash camera delay
		var _min_speed = _increment_value * PARAM_DASH_CHARGE;
		var _raw_camera_delay = -((abs(spd_ground) - _min_speed) * 2) + 32;
		
	    m_player_set_camera_delay(floor(_raw_camera_delay / 2));
	    audio_play_sfx(sfx_release2);
		
	    if global.fix_dash_release
	    {
	        m_player_set_velocity_from_speed();
	    }
		
		// Exit the player control routine
	    return true;
	}
	else
	{
	    spd_ground = 0;
	}

	return false;
}