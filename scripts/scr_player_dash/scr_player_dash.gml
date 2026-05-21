/// @self obj_player
function scr_player_dash()
{
	if !global.dash || player_type != PLAYER.SONIC || player_index > 0 && cpu_control_timer == 0
	{
	    return false;
	}
	
	if action != ACTION.DASH
	{    
	    if action == ACTION.NONE && animation == ANIM.LOOKUP && input_down.up && input_press_action_any()
	    {
	        animation = ANIM.MOVE;
	        action = ACTION.DASH;
	        dash_vel = 0;
			
	        audio_sfx_play(snd_dash_charge, [1.00, 2.30]);
	    }
	    else
	    {
	        return false;    
	    }
	}
	
	var _increment_value = 0.390625;
	var _min_speed = _increment_value * 30;
	var _speed_cap = item_speed_timer > 0 || super_timer > 0 ? acc_top * 1.5 : acc_top * 2;

	if input_down.up
	{
	    dash_vel = min(dash_vel + _increment_value, _speed_cap);
	    spd = dash_vel * facing;
        
	    return false;
	}
	
	if abs(spd) >= min(_min_speed, _speed_cap)
	{
		action = ACTION.NONE;
		
		// There is no camera delay for Dash in CD, so we assume it uses the same logic as the Spin Dash camera delay
		var _raw_camera_delay = -((abs(spd) - _min_speed) * 2) + 32;
		
		audio_stop_sound(snd_dash_charge);
		audio_sfx_play(snd_dash_release);
		
	    set_camera_delay(floor(_raw_camera_delay * 0.5));
		set_velocity();
		
		// Exit the player control routine
	    return true;
	}
	
	action = ACTION.NONE;
	spd = 0;
	
	audio_stop_sound(snd_dash_charge);
	
	return false;
}