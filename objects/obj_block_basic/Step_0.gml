for (var p = 0; p < PLAYER_COUNT; p++)
{
	var _player = player_get(p);
	var _is_spinning = _player.animation == ANI_SPIN;

	obj_act_solid(_player, SOLIDOBJECT.FULL, _is_spinning ? SOLIDATTACH.NONE : SOLIDATTACH.DEFAULT);

	if !_is_spinning || !obj_check_solid(_player, SOLIDCOLLISION.TOP)
	{
		continue;
	}

	// Release all players attached to this object
	with obj_player if on_object == other.id
	{
		on_object = noone;
		is_grounded = false;
	}
	
	_player.is_grounded = false;
	_player.vel_y = -3;
	_player.m_player_add_score(++_player.score_combo);
	
	instance_create(x, y, obj_score, { ScoreCombo: _player.score_combo });

	// Create fragments in a 2x2 grid pattern
	for (var i = 0; i < 2; i++)
	{
		for (var j = 0; j < 2; j++)
		{
			var _vel_x = -2;
			var _vel_y = -2;

			if i > 0
			{
				_vel_x *= -1;
			}

			if j > 0
			{
				_vel_y = _vel_y / 2;
				_vel_x = _vel_x / 2;
			}

			instance_create(x - 8 + i * 16, y - 8 + j * 16, obj_fragment,
			{
				VelocityX: _vel_x,
				VelocityY: _vel_y,
				Gravity: 0.21875,
				Sprite: sprite_index,
				X: 16 * i,
				Y: 16 * j,
				Width: 16,
				Height: 16
			});
		}
	}

	// Play sound effect and destroy the block
	audio_play_sfx(sfx_break_block);
	instance_destroy();

	break;
}