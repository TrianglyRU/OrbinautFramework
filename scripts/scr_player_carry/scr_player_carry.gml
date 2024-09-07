/// @function scr_player_carry
function scr_player_carry()
{
	gml_pragma("forceinline");

	// Check if the player is Tails
	if PlayerType != PLAYER_TAILS
	{
		exit;
	}

	if carry_cooldown != 0
	{
		carry_cooldown--;
		exit;
	}

	/// @method m_local_attach_to_tails
	var m_local_attach_to_tails = function(_who, _tails)
	{
		var _target_x = _tails.x;
		var _target_y = _tails.y + 28;
	
		_who.x = _target_x;
		_who.y = _target_y;
		_who.image_xscale = _tails.facing;
		_who.facing = _tails.facing;
		_who.vel_x = _tails.vel_x;
		_who.vel_y = _tails.vel_y;
	
		_tails.carry_target_x = _target_x;
		_tails.carry_target_y = _target_y;
	}

	// Manage carry target and Tails interactions
	if carry_target == noone
	{
		if action != ACTION_FLIGHT
		{
			exit;
		}

		for (var p = 0; p < PLAYER_COUNT; p++)
		{
			if p == player_index
			{
				continue;
			}
		
			var _player = player_get(p);
		
			if _player.action == ACTION_SPINDASH || _player.action == ACTION_CARRIED || _player.state >= PLAYER_STATE_NO_CONTROL
			{
				continue;
			}
		
			var _dist_x = floor(_player.x) - floor(x);
			var _dist_y = floor(_player.y) - floor(y);
		
			if abs(_dist_x) < 16 && abs(_dist_y) - 32 < 16
			{
				_player.m_player_reset();
				_player.animation = ANI_GRAB;
				_player.action = ACTION_CARRIED;
				carry_target = _player;
			
				audio_play_sfx(sfx_grab);
				m_local_attach_to_tails(_player, id);
				
				break;
			}	
		}

		exit;
	}

	// Handle actions for the carried player
	var _carried = carry_target;
	
	if _carried.action != ACTION_CARRIED
	{
		m_player_tails_clear_carry();
	}
	else if _carried.input_press.action_any
	{
		carry_target = noone;
		carry_cooldown = 18;
		
		_carried.is_jumping = true;
		_carried.action = ACTION_NONE;
		_carried.animation = ANI_SPIN;
		_carried.radius_x = _carried.radius_x_spin;
		_carried.radius_y = _carried.radius_y_spin;
		_carried.vel_y = _carried.jump_min_vel;
	
		if _carried.input_down.left
		{
			_carried.vel_x = -2;
		}
		else if _carried.input_down.right
		{
			_carried.vel_x = 2;
		}

		audio_play_sfx(sfx_jump);
	}
	else if floor(_carried.x) != floor(carry_target_x) || floor(_carried.y) != floor(carry_target_y)
	{
		m_player_tails_clear_carry();
	}
	else
	{
		m_local_attach_to_tails(_carried, id);
		
		// Run carried player's level collision
		with _carried
		{
			scr_player_collision_air();
		}
	}
}