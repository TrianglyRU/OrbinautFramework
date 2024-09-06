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
	var _launch_speed = (item_speed_timer > 0 || super_timer > 0) ? acc_top * 1.5 : acc_top * 2;

	if input_down.up
	{
	    if dash_charge < PARAM_DASH_CHARGE
	    {
	        dash_charge++;
	    }
		
	    dash_vel = clamp(dash_vel + 0.390625 * facing, -_launch_speed, _launch_speed);
	    spd_ground = dash_vel;
	    return false;
	}

	audio_stop_sound(sfx_charge2);
	action = ACTION_NONE;

	// Release Dash or reset if not fully charged
	if dash_charge == PARAM_DASH_CHARGE
	{
	    m_player_set_camera_delay(16);
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