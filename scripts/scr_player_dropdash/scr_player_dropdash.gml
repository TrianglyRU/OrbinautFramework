/// @function scr_player_dropdash
function scr_player_dropdash()
{
	gml_pragma("forceinline");
	
	if !global.drop_dash || action != ACTION_DROPDASH
	{
	    exit;
	}

	// Perform Drop Dash if grounded and charge is sufficient (called by m_player_land())
	if is_grounded && dropdash_charge >= PARAM_DROPDASH_CHARGE
	{
	    y += radius_y - radius_y_spin;
	    radius_x = radius_x_spin;
	    radius_y = radius_y_spin;
    
	    var _force = 8;
	    var _max_speed = 12;
	    var _camera_is_valid = camera_data.target == noone && player_index == camera_data.index;

	    if super_timer > 0
	    {
	        _force = 12;
	        _max_speed = 13;
			
	        if _camera_is_valid
	        {
	            camera_data.shake_timer = 6;
	        }
	    }

	    if facing == DIRECTION.NEGATIVE
	    {
	        if vel_x <= 0 
	        {
	            spd_ground = (spd_ground >> 2) - _force;  // is floor(spd_ground / 4)
				
	            if spd_ground < -_max_speed
	            {
	                spd_ground = -_max_speed;
	            }
	        }
	        else if angle != 0
	        {
	            spd_ground = (spd_ground >> 1) - _force;  // is floor(spd_ground / 2)
	        }
	        else
	        {
	            spd_ground = -_force;
	        }
	    }
	    else
	    {
	        if vel_x >= 0
	        {
	            spd_ground = (spd_ground >> 2) + _force;
				
	            if spd_ground > _max_speed
	            {
	                spd_ground = _max_speed;
	            }
	        }
	        else if angle != 0
	        {
	            spd_ground = (spd_ground >> 1) + _force;
	        }
	        else 
	        {
	            spd_ground = _force;
	        }
	    }
    
	    // Update animation and create dust effect
	    animation = ANI_SPIN;
		
	    instance_create(x, y + radius_y, obj_dust_dropdash, { image_xscale: facing });
	    audio_stop_sound(sfx_charge3);
	    audio_play_sfx(sfx_release);
	    m_player_set_camera_delay(8);
		
	    exit;
	}
	
	if shield > SHIELD_NORMAL && super_timer <= 0 && item_inv_timer == 0
	{
		// Force-cancel Drop Dash and reset to default action
	    animation = ANI_SPIN;
	    action = ACTION_NONE;
	}

	// Manage Drop Dash charge based on input
	else if input_down.action_any
	{
	    if ++dropdash_charge == PARAM_DROPDASH_CHARGE
	    {
	        audio_play_sfx(sfx_charge3);
	    }
		
	    air_lock_flag = false;
	}
	else if dropdash_charge > 0
	{
	    if dropdash_charge >= PARAM_DROPDASH_CHARGE
	    {        
	        animation = ANI_SPIN;
	        action = ACTION_DROPDASH_C;
	    }
		
	    dropdash_charge = 0;
	}
}