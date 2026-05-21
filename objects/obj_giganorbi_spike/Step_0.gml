switch state
{
	case GIGANSPIKE_STATE.ROTATE:
	
		if parent_boss != noone
		{
			if parent_boss.boss_inv_frames != 0
			{
				visible = obj_game.frame_counter % 2 != 0; 
			}
			else
			{
				visible = true; hurt_player();	
			}
			
			var _angle = math_get_vector_rounded(parent_boss.x - x, parent_boss.y - y);
			var _priority = 50;
			
			if _angle >= 90 && _angle <= 270
			{
				image_index = 0; _priority = 30;
			}
			else if _angle >= 45 && _angle <= 315
			{
				image_index = 1;
			}
			else
			{
				image_index = 2;
			}
			
			depth = draw_depth(_priority);
			
			break;
		}
		
		var _vel_x = random_range(-2.5, 2.5);
		var _vel_y = random_range(-3.25, -2.75);
		var _delay = irandom(80) + 20;
		
		instance_create_piece(x, y, sprite_index, image_index, 0, 0, 48, 48, _vel_x, _vel_y, _delay, false, false, true);
		instance_destroy();
		
	break;

	case GIGANSPIKE_STATE.LAUNCHED:
		
		if ++fly_timer > 120
		{
			if !instance_is_drawn()
			{
				instance_destroy(); break;
			}
		}
		
		hurt_player();
		
		x += vel_x;
		y += vel_y;
		
	break;
}