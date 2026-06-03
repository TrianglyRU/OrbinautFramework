/// @self obj_player
function scr_player_carry()
{
	if player_type != PLAYER.TAILS
	{
		return;
	}
	
	if carry_cooldown > 0
	{
		carry_cooldown--;
		return;
	}
	
	if carry_target == noone
	{
		if action != ACTION.FLIGHT
		{
			return;
		}

		FOR_EACH_PLAYER
		{
			if _p == player_index
			{
				continue;
			}
			
			var _player = player_get(_p);	
			
			if _player.action != ACTION.NONE || _player.state != PLAYER_STATE.DEFAULT
			{
				continue;
			}
		
			var _dist_x = floor(_player.x) - floor(x);
			var _dist_y = floor(_player.y) - floor(y);
			
			if abs(_dist_x) < 16 && abs(_dist_y) - 32 < 16
			{
				carry_target = _player;
				
				_player.reset_substate();		
				_player.animation = ANIM.GRAB;
				_player.action = ACTION.CARRIED;
				
				audio_sfx_play(snd_grab);
				_attach_to_tails(_player);		
				
				with _player
				{
					scr_player_collision_air_regular();
				}
				
				break;
			}	
		}
	}
	else if carry_target.action != ACTION.CARRIED
	{
		clear_carry();
	}
	else if carry_target.input_press_action_any()
	{
		carry_target.is_jumping = true;
		carry_target.action = ACTION.NONE;
		carry_target.animation = ANIM.SPIN;
		carry_target.radius_x = carry_target.radius_x_spin;
		carry_target.radius_y = carry_target.radius_y_spin;
		carry_target.vel_y = carry_target.jump_min_vel;
		
		var _input_down = carry_target.input_down;
		
		if _input_down.left
		{
			carry_target.vel_x = -2;
		}
		else if _input_down.right
		{
			carry_target.vel_x = 2;
		}
		
		carry_target = noone;
		carry_cooldown = 18;
		
		audio_sfx_play(snd_jump);
	}
	else if floor(carry_target.x) != floor(carry_target_x) || floor(carry_target.y) != floor(carry_target_y)
	{
		clear_carry();
	}
	else
	{
		_attach_to_tails(carry_target);
		
		with carry_target
		{
			scr_player_collision_air_regular();
		}
	}
}

/// @self scr_player_carry
function _attach_to_tails(_attached_player)
{
	var _target_x = x;
	var _target_y = y + 28;
	
	_attached_player.x = _target_x;
	_attached_player.y = _target_y;
	_attached_player.image_xscale = facing;
	_attached_player.facing = facing;
	_attached_player.vel_x = vel_x;
	_attached_player.vel_y = vel_y;
	
	carry_target_x = _target_x;
	carry_target_y = _target_y;
}