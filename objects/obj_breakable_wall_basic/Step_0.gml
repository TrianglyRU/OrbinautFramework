for (var p = 0; p < PLAYER_COUNT; p++)
{
	var _player = player_get(p);
	var _smash_vel = _player.vel_x;
	
	obj_act_solid(_player, SOLIDOBJECT.SIDES);

	if KnucklesOnly && _player.PlayerType != PLAYER_KNUCKLES
	{
		continue;
	}
	
	// Check if the player meets conditions to interact with the breakable wall
	if !(_player.animation == ANI_SPIN && _player.is_grounded && abs(_smash_vel) >= 4
	  || _player.PlayerType == PLAYER_KNUCKLES
	  || _player.action == ACTION_HAMMERSPIN
	  || _player.animation == ANI_HAMMERDASH
	  || _player.shield == SHIELD_FIRE && _player.shield_state == SHIELD_STATE_ACTIVE
	  || _player.super_timer > 0)
	{
		continue;
	}

	var _side = _player.x < x ? SOLIDCOLLISION.LEFT : SOLIDCOLLISION.RIGHT;

	if !obj_check_solid(_player, _side)
	{
		continue;
	}

	// Update the player properties and position
	with _player
	{
		if (action == ACTION_GLIDE && action_state == GLIDE_STATE_AIR)
		{
			m_player_glide_release(0);
		}
		
		x -= 4 * sign(_smash_vel);
		vel_x = _smash_vel;
		spd_ground = vel_x;
		set_push_anim_by = noone;
	}
	
	var _smash_dir = floor(_player.x) >= x ? 1 : -1;

	for (var i = 0; i < 2; i ++)
	{
		for (var j = 0; j < 4; j++)
		{
			var _vel_x = 6 * _smash_dir;
			var _vel_y = -6 + 4 * j;

			if _smash_dir == -1 && i == 1 || _smash_dir == 1 && i == 0
			{
				_vel_x -= 2 * sign(_vel_x);
				_vel_y -= 1 * sign(_vel_y);
			}

			// Create fragments with specified properties
			instance_create(x - 8 + 16 * i, y - 24 + 16 * j, obj_fragment,
			{
				VelocityX: _vel_x,
				VelocityY: _vel_y,
				Gravity: PARAM_GRV_DEFAULT,
				Sprite: sprite_index,
				FrameIndex: image_index,
				X: 16 * i,
				Y: 16 * j,
				Width: 16,
				Height: 16
			});
		}
	}

	// Play sound effect and destroy the breakable wall
	audio_play_sfx(sfx_break_block);
	instance_destroy();

	break;
}