switch state
{
	case PLATFORM_STATE_MOVE:
	
		// Detect if a player is touching the platform
		player_touch = false;

		for (var p = 0; p < PLAYER_COUNT; p++)
		{
			var _player = player_get(p);

			if obj_check_solid(_player, SOLIDCOLLISION.TOP)
			{
				player_touch = true;
				break;
			}
		}

		// Adjust platform weight based on player contact
		var WEIGHT_INC = 5.625;

		if player_touch
		{
			if weight < 90
			{
				weight += WEIGHT_INC;
			}
		}
		else if weight > 0
		{
			weight -= WEIGHT_INC;
		}

		// Move the platform based on its type
		var _reverse = ReverseMovement * 180;
		var _osc_angle = c_framework.frame_counter * ANGLE_INCREMENT;

		switch Type
		{
			case "None":
				y = ystart;
			break;
			
			case "Horizontal":
			
				x = obj_oscillate_x(xstart, _osc_angle, 64, 1, _reverse + AngleOffset);
				y = ystart;
				
			break;

			case "Vertical":
				y = obj_oscillate_y(ystart, _osc_angle + 90, 64, 1, _reverse + AngleOffset);
			break;

			case "Circular":
			
				var _spd = 256 / 572;
				x = obj_oscillate_x(xstart, _osc_angle, 80, _spd, _reverse + AngleOffset);
				y = obj_oscillate_y(ystart, _osc_angle, 80, _spd, _reverse + AngleOffset);
				
			break;

			case "Falls":
				
				y = ystart;
				
				if wait_timer == 0
				{
					if player_touch
					{
						wait_timer = 30;
					}
				}
				else if --wait_timer == 0
				{
					state = PLATFORM_STATE_FALL;
					wait_timer = 32;
				}
				
			break;
		}

		y += dsin(weight) * 4;
		
		for (var p = 0; p < PLAYER_COUNT; p++)
		{
			obj_act_solid(player_get(p), SOLIDOBJECT.TOP);
		}

	break;

	case PLATFORM_STATE_FALL:
	
		if --wait_timer == 0
		{
			// Release all players attached to this object
			with obj_player if on_object == other.id
			{
				on_object = noone;
				is_grounded = false;
				vel_y = other.vel_y;
			}
		}

		y += vel_y;
		vel_y += 0.21875;
		
		// Act as solid only for players already on the platform
		if wait_timer > 0
		{
			for (var p = 0; p < PLAYER_COUNT; p++)
			{
				obj_act_solid(player_get(p), SOLIDOBJECT.TOP, SOLIDATTACH.NONE);
			}
		}

	break;
}