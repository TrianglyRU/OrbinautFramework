// Inherit the parent event
event_inherited();

if turn_timer <= 0
{
	flame_timer++;
}

switch state
{
	case BUZZER_STATE.ROAM:
	
	    if shot_flag
	    {
	        var _player = player_get(obj_game.frame_counter % PLAYER_COUNT);
	        var _dist_x = x - floor(_player.x);
	        var _abs_dist_x = abs(_dist_x);
			
	        if _abs_dist_x >= 40 && _abs_dist_x <= 48 && sign(_dist_x) == sign(image_xscale)
	        {
	            state = BUZZER_STATE.SHOOT;
				shot_timer = 50;
	            shot_flag = false;
	            image_index = 1;
	        }
	    }
		
	    if --turn_timer >= 0
	    {
	        if turn_timer == 15
	        {
	            move_timer = BUZZER_DEFAULT_MOVE_TIMER;
	            shot_flag = true;
	            image_xscale *= -1;
	        }
			
	        break;
	    }
        
	    if --move_timer > 0
	    {
	        x -= sign(image_xscale);
	    }
	    else
	    {
	        turn_timer = 30;
			flame_timer = -1;
	    }
		
	break;
	
	case BUZZER_STATE.SHOOT:
		
	    if --shot_timer < 0
	    {
	        state = BUZZER_STATE.ROAM;
	        image_index = 0;
	    }
	    else if shot_timer == 20
	    {
	        instance_create(x + 5 * image_xscale, y + 26, obj_buzzer_projectile, { image_xscale: image_xscale });
	    }
		
	break;
}