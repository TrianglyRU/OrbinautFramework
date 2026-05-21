/// @self obj_player
function scr_player_movement_ground_roll()
{
	if ground_lock_timer == 0
	{
	    if input_down.left
	    {
	        if spd > 0
	        {
	            spd -= dec_roll;
				
	            if spd < 0
	            {
	                spd = -0.5;
	            }
	        }
	        else
	        {
	            facing = -1;
	            set_push_anim_by = noone;
	        }
	    }

	    if input_down.right
	    {
	        if spd < 0
	        {
	            spd += dec_roll;
				
	            if spd >= 0
	            {
	                spd = 0.5;
	            }
	        }
	        else
	        {
	            facing = 1;
	            set_push_anim_by = noone;
	        }
	    }
	}
	
	if spd > 0
	{
	    spd = max(spd - frc_roll, 0);
	}
	else if spd < 0
	{
	    spd = min(spd + frc_roll, 0);
	}

	if !is_forced_roll
	{
	    if spd == 0 || global.player_physics == PHYSICS.SK && abs(spd) < 0.5
	    {
	        y += radius_y - radius_y_normal;
	        radius_x = radius_x_normal;
	        radius_y = radius_y_normal;
	        animation = ANIM.IDLE;
	    }
	}
	else
	{
	    if global.player_physics == PHYSICS.CD
	    {
	        if spd >= 0 && spd < 2
	        {
	            spd = 2;
	        }
	    }
	    else if spd == 0
	    {
	        spd = global.player_physics == PHYSICS.S1 ? 2 : 4 * facing;
	    }
	}
	
	set_velocity();
	
	if global.roll_speed_cap
	{
		vel_x = clamp(vel_x, -16, 16);
	}
}
