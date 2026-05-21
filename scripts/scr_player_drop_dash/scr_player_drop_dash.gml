/// @self obj_player
function scr_player_drop_dash()
{
	if !global.drop_dash || action != ACTION.DROP_DASH
	{
	    return;
	}
	
	if is_grounded && dropdash_charge >= PARAM_DROPDASH_CHARGE
	{
	    y += radius_y - radius_y_spin;
	    radius_x = radius_x_spin;
	    radius_y = radius_y_spin;
		
	    var _force = 8;
	    var _max_speed = 12;

	    if super_timer > 0
	    {
	        _force = 12;
	        _max_speed = 13;
			
	        if camera_data.target == noone && player_index == camera_data.index
	        {
	            camera_data.shake_timer = 6;
	        }
	    }

	    if facing == -1
	    {
	        if vel_x <= 0
	        {
	            spd = (spd >> 2) - _force;  // is floor(spd / 4)
				
	            if spd < -_max_speed
	            {
	                spd = -_max_speed;
	            }
	        }
	        else if angle != 0
	        {
	            spd = (spd >> 1) - _force;  // is floor(spd / 2)
	        }
	        else
	        {
	            spd = -_force;
	        }
	    }
	    else
	    {
	        if vel_x >= 0
	        {
	            spd = (spd >> 2) + _force;
				
	            if (spd > _max_speed)
	            {
	                spd = _max_speed;
	            }
	        }
	        else if angle != 0
	        {
	            spd = (spd >> 1) + _force;
	        }
	        else 
	        {
	            spd = _force;
	        }
	    }
		
	    animation = ANIM.SPIN;
		set_camera_delay(8);
		
	    instance_create(x, y + radius_y, obj_drop_dash_dust, { image_xscale: facing });
	    audio_stop_sound(snd_drop_dash);
	    audio_sfx_play(snd_spin_release);
		
	    return;
	}
	
	if global.player_shields[player_index] > SHIELD.NORMAL && super_timer <= 0 && item_inv_timer == 0
	{
	    action = ACTION.NONE;
	}
	else if input_down_action_any()
	{
        if dropdash_charge >= 0 && ++dropdash_charge == PARAM_DROPDASH_CHARGE
        {
            audio_sfx_play(snd_drop_dash);
      	}
        
        air_lock_flag = false;
	}
	else if dropdash_charge > 0
	{
	    dropdash_charge = dropdash_charge >= PARAM_DROPDASH_CHARGE ? -1 : 0;
	}
}