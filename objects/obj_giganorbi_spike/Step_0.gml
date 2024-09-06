/// @method m_local_hurt_player
var m_local_hurt_player = function()
{
	if image_index == 2
	{
		exit;
	}

	for (var p = 0; p < PLAYER_COUNT; p++)
	{
		var _player = player_get(p);
		
		if obj_check_hitbox(_player)
		{
			_player.m_player_hurt();
		}
	}
}


switch state
{
	case GIGAN_SPIKE_STATE_ROTATE:
	
		if ParentBoss != noone
		{
			// Toggle visibility based on invincibility frames
			if ParentBoss.boss_inv_frames != 0
			{
				visible = c_framework.frame_counter % 2 != 0; 
			}
			else
			{
				visible = true;
				m_local_hurt_player();	
			}

			// Update image index and priority based on angle to ParentBoss
			var _angle = math_get_vector_rounded(ParentBoss.x - x, ParentBoss.y - y);
			var _priority = 5;
			
			if _angle >= 90 && _angle <= 270
			{
				image_index = 0; _priority = 3;
			}
			else if _angle >= 45 && _angle <= 315
			{
				image_index = 1;
			}
			else
			{
				image_index = 2;
			}
			
			obj_set_priority(_priority);
			break;
		}

		// Create fragment instances and destroy self
		instance_create(x, y, obj_fragment,
		{
			VelocityX: random_range(-3, 3),
			VelocityY: random_range(-0.25, 3), 
			Gravity: PARAM_GRV_DEFAULT, 
			Sprite: sprite_index,
			ImageIndex: image_index,
			Width: 48,
			Height: 48,
			DoFlicker: true
		});
		
		instance_destroy();
		
	break;

	case GIGAN_SPIKE_STATE_LAUNCHED:
	
		if ++fly_timer == 32
		{
			obj_set_culling(CULLING.REMOVE);
		}

		m_local_hurt_player();

		x += vel_x;
		y += vel_y;
		
	break;
}