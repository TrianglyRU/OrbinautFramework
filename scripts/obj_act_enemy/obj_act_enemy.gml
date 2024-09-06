/// @self
/// @description Defines the behaviour and logic for an enemy object. Returns true if the enemy was not destroyed, false otherwise.
/// @param {Enum.ENEMYTYPE} [type] The type of enemy (optional, defaults to ENEMYTYPE.BADNIK)
/// @returns {Bool} 
function obj_act_enemy(_type = ENEMYTYPE.BADNIK)
{
	/// @method m_local_destroy_badnik
	var m_local_destroy_badnik = function(_player)
	{
		_player.m_player_add_score(++_player.score_combo);
		instance_create(x, y, obj_score, { ScoreCombo: _player.score_combo });
		instance_create(x, y, obj_animal);
		instance_create(x, y, obj_explosion_dust);
		instance_destroy();
	}

	// Check fo badnik enemy behaviour
	if _type == ENEMYTYPE.BADNIK
	{
		if instance_exists(obj_water_flash) && y >= c_stage.water_level
		{
			m_local_destroy_badnik(player_get(0));
			return false;
		}
	}

	// Process interactions with players
	for (var p = 0; p < PLAYER_COUNT; p++)
	{
		var _player = player_get(p);
		var _action_check = false;
		var _tails_check = false;
		var _inv_check = false;
		
		if !obj_check_hitbox(_player, true)
		{
			continue;
		}

		// Check if player is performing actions that affect enemy interaction
		if _player.action == ACTION_GLIDE && _player.action_state != GLIDE_STATE_FALL 
		|| _player.animation == ANI_HAMMERDASH || _player.animation == ANI_SPIN || _player.action == ACTION_SPINDASH
		{
			_action_check = true;
		}

		// Check if player is flying and if the direction is downward
		if _player.action == ACTION_FLIGHT
		{
			var _vector = math_get_vector_rounded(_player.x - x, _player.y - y);
			if math_get_quadrant(_vector) == QUADRANT.DOWN
			{
				_tails_check = true;
			}
		}

		// Check for player invincibility
		if _player.super_timer > 0 || _player.item_inv_timer > 0
		{
			_inv_check = true; 
		}

		// If no checks passed, hurt the player
		if !_action_check && !_tails_check && !_inv_check
		{
			_player.m_player_hurt();
			continue;
		}
		
		// Handle boss enemy behaviour
		if _type == ENEMYTYPE.BOSS
		{
			if !_player.is_grounded
			{
				_player.vel_x *= -0.5;
				_player.vel_y *= -0.5;
			}
			
			input_set_rumble(_player.player_index, 0.10, INPUT_RUMBLE_LIGHT, INPUT_RUMBLE_LIGHT);
			return false;
		}
		
		// Adjust player velocity based on enemy interaction
		if !_player.is_grounded
		{
			if floor(_player.y - y) >= 0 || _player.vel_y < 0
			{
				_player.vel_y -= _player.vel_y < 0 ? -1 : 1;
			}
			else if _player.vel_y > 0
			{
				_player.vel_y *= -1;
			}
		}
		
		input_set_rumble(_player.player_index, 0.10, INPUT_RUMBLE_LIGHT, INPUT_RUMBLE_LIGHT);
		m_local_destroy_badnik(_player);
		
		return false;
	}
	
	return true;
}