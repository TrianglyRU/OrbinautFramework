/// @function scr_player_glide
function scr_player_glide()
{
	gml_pragma("forceinline");
	
	if action != ACTION_GLIDE || action_state == GLIDE_STATE_FALL
	{
	    exit;
	}

	var ANGLE_INC = 2.8125;
	var GLIDE_GRV = 0.125;
	var SLIDE_FRC = 0.09375;

	switch action_state
	{
	    case GLIDE_STATE_AIR:
		
	        // Update glide speed. Glide speed uses spd_ground like the originals, this is
			// required by some objects (such as obj_star_super)
	        if spd_ground >= 4
	        {
	            if glide_angle % 180 == 0
	            {
	                spd_ground = min(spd_ground + acc_glide, 24);
	            }
	        }
	        else
	        {
	            spd_ground += 0.03125;
	        }
			
			// Turn around
	        if glide_angle != 0 && input_down.left
	        {
	            if glide_angle > 0
	            {
	                glide_angle = -glide_angle;
	            }
				
	            glide_angle += ANGLE_INC;
	        }
	        else if glide_angle != 180 && input_down.right
	        {
	            if glide_angle < 0
	            {
	                glide_angle = -glide_angle;
	            }
				
	            glide_angle += ANGLE_INC;
	        }
	        else if glide_angle % 180 != 0
	        {
	            glide_angle += ANGLE_INC;
	        }
			
	        vel_x = spd_ground * -dcos(glide_angle);

	        // Set gravity based on vertical speed
	        if vel_y < 0.5
	        {
	            grv = GLIDE_GRV;
	        }
	        else
	        {
	            grv = -GLIDE_GRV;
	        }

	        // Update animation based on glide angle
	        var _angle = abs(glide_angle) % 180;
			
	        if _angle < 30 || _angle > 150
	        {
	            ani_update_frame(0, false);
	        }
	        else if _angle < 60 || _angle > 120
	        {
	            ani_update_frame(1, false);
	        }
	        else
	        {
	            facing = _angle < 90 ? DIRECTION.NEGATIVE : DIRECTION.POSITIVE;
	            ani_update_frame(2, false);
	        }
			
	        // Fall if no action button input is registered
	        if !input_down.action_any
	        {
				m_player_glide_release(0);
				vel_x *= 0.25;
	        }
			
	    break;

	    case GLIDE_STATE_GROUND:
		
	        if !input_down.action_any
	        {
	            vel_x = 0;
	        }
	        else if vel_x > 0
	        {
	            vel_x = max(0, vel_x - SLIDE_FRC);
	        }
	        else if vel_x < 0
	        {
	            vel_x = min(0, vel_x + SLIDE_FRC);
	        }
			
	        if vel_x == 0
	        {
	            m_player_land();
	            ani_update_frame(1, false);
				
	            animation = ANI_GLIDE_GROUND;
	            ground_lock_timer = 16;
	            spd_ground = 0;
	            break;
	        }

	        // Create dust effects and play sound based on glide_value
	        if glide_value % 4 == 0
	        {
	            instance_create(x, y + radius_y, obj_dust_skid);
	        }
			
	        if glide_value > 0 && glide_value % 8 == 0
	        {
	            audio_play_sfx(sfx_slide);
	        }
			
	        glide_value++;
			
	    break;
	}
}