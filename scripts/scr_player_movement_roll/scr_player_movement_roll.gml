/// @function scr_player_movement_roll
function scr_player_movement_roll()
{
	gml_pragma("forceinline");

	if ground_lock_timer == 0
	{
	    // Handle movement to the left
	    if input_down.left
	    {
	        if spd_ground > 0
	        {
	            spd_ground -= dec_roll;
	            if spd_ground < 0
	            {
	                spd_ground = -0.5;
	            }
	        }
	        else
	        {
	            facing = DIRECTION.NEGATIVE;
	            set_push_anim_by = noone;
	        }
	    }

	    // Handle movement to the right
	    if input_down.right
	    {
	        if spd_ground < 0
	        {
	            spd_ground += dec_roll;
	            if spd_ground >= 0
	            {
	                spd_ground = 0.5;
	            }
	        }
	        else
	        {
	            facing = DIRECTION.POSITIVE;
	            set_push_anim_by = noone;
	        }
	    }
	}

	// Apply friction
	if spd_ground > 0
	{
	    spd_ground = max(spd_ground - frc_roll, 0);
	}
	else if spd_ground < 0
	{
	    spd_ground = min(spd_ground + frc_roll, 0);
	}

	if !forced_roll
	{
		// Stop rolling
	    if spd_ground == 0 || (global.player_physics == PHYSICS_SK && abs(spd_ground) < 0.5)
	    {
	        y += radius_y - radius_y_normal;
	        radius_x = radius_x_normal;
	        radius_y = radius_y_normal;
	        animation = ANI_IDLE;
	    }
	}
	else
	{
		// Force to roll
	    if global.player_physics == PHYSICS_CD
	    {
	        if spd_ground >= 0 && spd_ground < 2
	        {
	            spd_ground = 2;
	        }
	    }
	    else if spd_ground == 0
	    {
	        spd_ground = (global.player_physics == PHYSICS_S1) ? 2 : 4 * facing;
	    }
	}
	
	m_player_set_velocity_from_speed();
	
	// Limit our horizontal velocity
	vel_x = clamp(vel_x, -16, 16);
}