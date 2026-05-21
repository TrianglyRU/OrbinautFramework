/// @self obj_player
function scr_player_glide()
{
	if !is_true_glide()
	{
	    return;
	}
	
	var _angle_inc = 2.8125;
	var _glide_grv = 0.125;
	var _slide_frc = 0.09375;
	var _input_down_any = input_down.action1 || input_down.action2 || input_down.action3;

	// spd is used as a glide speed
	switch action_state
	{
	    case GLIDE_STATE.AIR:
		
	        if spd >= 4
	        {
	            if glide_angle % 180 == 0
	            {
	                spd = min(spd + acc_glide, 24);
	            }
	        }
	        else
	        {
	            spd += 0.03125;
	        }
			
	        if glide_angle != 0 && input_down.left
	        {
	            if glide_angle > 0
	            {
	                glide_angle = -glide_angle;
	            }
				
	            glide_angle += _angle_inc;
	        }
	        else if glide_angle != 180 && input_down.right
	        {
	            if glide_angle < 0
	            {
	                glide_angle = -glide_angle;
	            }
				
	            glide_angle += _angle_inc;
	        }
	        else if glide_angle % 180 != 0
	        {
	            glide_angle += _angle_inc;
	        }
			
			facing = abs(glide_angle) < 90 ? -1 : 1; 
	        vel_x = spd * -dcos(glide_angle);
			
	        if vel_y < 0.5
	        {
	            grv = _glide_grv;
	        }
	        else
	        {
	            grv = -_glide_grv;
	        }
			
	        if !_input_down_any
	        {
				vel_x *= 0.25;
				release_glide(0);
	        }
			
	    break;

	    case GLIDE_STATE.GROUND:
		
	        if !_input_down_any
	        {
	            vel_x = 0;
	        }
	        else if vel_x > 0
	        {
	            vel_x = max(0, vel_x - _slide_frc);
	        }
	        else if vel_x < 0
	        {
	            vel_x = min(0, vel_x + _slide_frc);
	        }
			
	        if vel_x == 0
	        {
	            land();
	            animation = ANIM.GLIDE_GROUND;	// Keep the animation
	            ground_lock_timer = 16;
	            spd = 0;
				image_index = 1;
				
	            break;
	        }
			
	        if glide_value % 4 == 0
	        {
	            instance_create(x, y + radius_y, obj_skid_dust);
	        }
			
	        if glide_value > 0 && glide_value % 8 == 0
	        {
	            audio_sfx_play(snd_slide);
	        }
			
	        glide_value++;
			
	    break;
	}
}