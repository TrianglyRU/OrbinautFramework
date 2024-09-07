/// @method m_player_set_velocity_from_speed
m_player_set_velocity_from_speed = function()
{
	vel_x = spd_ground * dcos(angle);
	vel_y = spd_ground * -dsin(angle);
}

/// @method m_player_respawn
m_player_respawn = function()
{
	scr_player_init();

	if player_index > 0
	{
		x = 127;
		y = 0;
		depth = RENDERER_DEPTH_HIGHEST + player_index;	
		cpu_state = CPU_STATE_RESPAWN_INIT;
		state = PLAYER_STATE_NO_CONTROL;
		is_grounded = false;
	}
	else
	{
		camera_data.allow_movement = true;
		state = PLAYER_STATE_MAIN_RESPAWN;
	}
}

/// @method m_player_reset
m_player_reset = function()
{
	switch action
	{
		case ACTION_DASH:
			audio_stop_sound(sfx_charge2);
		break;

		case ACTION_FLIGHT:
			audio_stop_sound(sfx_flight);
			audio_stop_sound(sfx_flight2);
		break;
	}

	action = ACTION_NONE;
	shield_state = SHIELD_STATE_NONE;
	is_jumping = false;
	is_grounded = false;
	forced_roll = false;
	on_object = noone;
	set_push_anim_by = noone;
	radius_x = radius_x_normal;
	radius_y = radius_y_normal;
	visual_angle = 0;
	m_player_tails_clear_carry();
}

/// @method m_player_reset_gravity
m_player_reset_gravity = function()
{
	grv = is_underwater ? PARAM_GRV_UNDERWATER : PARAM_GRV_DEFAULT;
}

/// @method m_player_glide_release
m_player_glide_release = function(_frame)
{
	animation = ANI_GLIDE_FALL;
	action = ACTION_GLIDE;
	action_state = GLIDE_STATE_FALL;
	radius_x = radius_x_normal;
	radius_y = radius_y_normal;
	m_player_reset_gravity();
		
	// glide_value is the start frame of ANI_GLIDE_FALL
	glide_value = _frame;
}

/// @method m_player_land
m_player_land = function()
{
	m_player_reset_gravity();
	is_grounded = true;

	if action == ACTION_SPINDASH || action == ACTION_DASH || action == ACTION_HAMMERDASH
	{
		if action == ACTION_DASH
		{
			spd_ground = dash_vel;
		}

		exit;
	}

	if shield == SHIELD_BUBBLE && shield_state == SHIELD_STATE_ACTIVE
	{
		var _force = is_underwater ? -4 : -7.5;
		vel_y = _force * dcos(angle);
		vel_x = _force * dsin(angle);
		shield_state = SHIELD_STATE_NONE;
		on_object = noone;
		is_grounded = false;

		with obj_shield if TargetPlayer == other.id
		{
			ani_update(0, true, [3, 2], [12, 6], 1);
		}

		audio_play_sfx(sfx_shield_bubble2);
		exit;
	}

	if state == PLAYER_STATE_HURT
	{
		spd_ground = 0;
	}

	if carry_target != noone
	{
		carry_target.action = ACTION_NONE;
	}
	
	animation = ANI_MOVE;
	state = PLAYER_STATE_CONTROL;
	cpu_state = CPU_STATE_MAIN;
	shield_state = SHIELD_STATE_NONE;
	air_lock_flag = false;
	is_jumping = false;
	set_push_anim_by = noone;
	score_combo = 0;
	tile_behaviour = TILEBEHAVIOUR.DEFAULT;
	visual_angle = angle > 22.5 && angle < 337.5 ? angle : 0;

	scr_player_dropdash();
	scr_player_hammerspin();
	
	if action != ACTION_HAMMERDASH
	{
		action = ACTION_NONE;
	}

	if animation != ANI_SPIN
	{
		var _diff = radius_y_normal - radius_y;
		radius_x = radius_x_normal;
		radius_y = radius_y_normal;
		
		y = angle > 90 && angle <= 270 ? y + _diff : y - _diff;
	}
}

/// @method m_player_add_score
m_player_add_score = function(_score_combo)
{
	if _score_combo < 4
	{
		global.score_count += score_values[_score_combo]; 
	}
	else
	{
		global.score_count += score_values[_score_combo < 16 ? 4 : 5];
	}
}

/// @method m_player_is_invincible
m_player_is_invincible = function()
{
	return inv_frames > 0 || item_inv_timer > 0 || super_timer > 0 || shield_state == SHIELD_STATE_DOUBLESPIN;
}

/// @method m_player_hurt
m_player_hurt = function(_sound = sfx_hurt)
{
	if state != PLAYER_STATE_CONTROL || m_player_is_invincible()
	{
		return;
	}

	if player_index == 0 && global.player_rings == 0 && shield == SHIELD_NONE
	{
		m_player_kill(_sound);
		return;
	}
	
	m_player_reset();
	
	state = PLAYER_STATE_HURT;
	spd_ground = 0;
	vel_x = floor(x) < floor(other.x) ? -2 : 2;
	vel_y = -4;
	grv = 0.1875;
	animation = ANI_HURT;
	air_lock_flag = true;
	inv_frames = 120;

	if is_underwater
	{
		vel_x *= 0.5;
		vel_y *= 0.5;
		grv -= 0.15625;
	}

	if player_index == 0 && shield == SHIELD_NONE
	{
		var _ring_flip = -1;
		var _ring_angle = 101.25;
		var _ring_speed = 4;
		var _count = min(global.player_rings, 32);

		for (var i = 0; i < _count; i++) 
		{
			instance_create(x, y, obj_ring,
			{
				State: RING_STATE_DROP,			
				VelocityX: _ring_speed * dcos(_ring_angle) * -_ring_flip,
				VelocityY: _ring_speed * -dsin(_ring_angle)
			});

			if _ring_flip == 1
			{
				_ring_angle += 22.5;
			}

			if i == 15
			{
				_ring_speed = 2;
				_ring_angle = 101.25;
			}

			_ring_flip *= -1;
		}

		c_framework.ring_spill_counter = 256;
		global.player_rings = 0;
		global.life_rewards[0] = 100;
		audio_play_sfx(sfx_ring_loss);
	}
	else
	{
		shield = SHIELD_NONE;
		audio_play_sfx(_sound);
	}

	return;
}

/// @method m_player_kill
m_player_kill = function(_sound = sfx_hurt)
{
	if state == PLAYER_STATE_DEATH
	{
		exit;
	}

	audio_play_sfx(_sound);
	m_player_reset();

	if player_index == 0
	{
		c_framework.state = STATE_STOP_OBJECTS;
	}
	
	depth = RENDERER_DEPTH_HIGHEST + player_index;
	action = ACTION_NONE;
	animation = ANI_DEATH;
	state = PLAYER_STATE_DEATH;
	grv = 0.21875;
	vel_y = -7;
	vel_x = 0;
	spd_ground = 0;
	
	if player_index == camera_data.index
	{
		camera_data.allow_movement = false;
	}
}

/// @method m_player_set_camera_delay
m_player_set_camera_delay = function(_delay)
{
	if !global.cd_camera && camera_data.target == noone && player_index == camera_data.index
	{
		camera_data.delay_x = _delay;
	}
}

/// @method m_player_tails_clear_carry
m_player_tails_clear_carry = function()
{
	if carry_target != noone
	{
		carry_target.action = ACTION_NONE;
		carry_target = noone;
		carry_cooldown = 60;
	}
}

/// @method m_player_record_data
m_player_record_data = function(_insert_pos)
{
	if _insert_pos >= ds_record_length
	{
		exit;
	}

	var _data =
	[
		struct_copy(input_press), struct_copy(input_down), floor(x), floor(y), set_push_anim_by, facing
	];

	ds_list_insert(ds_record_data, _insert_pos, _data);
	ds_list_delete(ds_record_data, ds_record_length);
}

/// @method m_player_play_tails_sound
m_player_play_tails_sound = function()
{
	if (c_framework.frame_counter + 8) % 16 != 0 || !obj_is_visible() || is_underwater
	{
		exit;
	}

	if cpu_state == CPU_STATE_RESPAWN
	{
		if global.cpu_behaviour == CPU_BEHAVIOUR_S3
		{
			audio_play_sfx(sfx_flight);
		}

		exit;
	}

	if flight_timer > 0
	{
		audio_play_sfx(sfx_flight);
		exit;
	}

	audio_play_sfx(sfx_flight2);
}