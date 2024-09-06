// Act as an enemy and exit if destroyed
if !obj_act_enemy()
{
	exit;
}

switch state
{
	case BUZZER_STATE_ROAM:
	
	    if shooting_flag
	    {
	        // Select a player to shoot at
	        var _player = player_get(c_framework.frame_counter % PLAYER_COUNT);
	        var _dist_x = floor(x) - floor(_player.x);
	        var _abs_dist_x = abs(_dist_x);
				
	        // Check if the player is within the shooting range
	        if _abs_dist_x >= 40 && _abs_dist_x <= 48 && sign(_dist_x) == sign(image_xscale)
	        {
	            state = BUZZER_STATE_SHOOT;
	            shooting_flag = false;
	            shot_timer = 50;
	            image_index = 1;
	        }
	    }
        
	    // Handle turning
	    if --turn_delay >= 0
	    {
	        if turn_delay == 15
	        {
	            move_timer = BUZZER_DEFAULT_MOVE_TIMER;
	            shooting_flag = true;
	            vel_x *= -1;
	            flame_obj.image_xscale *= -1;
	            image_xscale *= -1;
	        }
	        break;
	    }
        
	    // Update position
	    if --move_timer > 0
	    {
	        x += vel_x;
	        flame_obj.x = x;
	    }
	    else
	    {
	        turn_delay = 30;
	    }
		
	break;
    
	case BUZZER_STATE_SHOOT:
	
	    // Transition back to roaming state after shot timer expires
	    if --shot_timer < 0
	    {
	        state = BUZZER_STATE_ROAM;
	        image_index = 0;
	    }
	    else if shot_timer == 20
	    {
	        // Create a projectile
	        instance_create(x + 5 * image_xscale, y + 26, obj_buzzer_projectile, 
	        { 
	            VelocityX: -1.5 * image_xscale, 
	            VelocityY: 1.5, 
	            image_xscale: image_xscale 
	        });
	    }
		
	break;
}