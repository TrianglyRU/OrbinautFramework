/// @function scr_player_spindash
function scr_player_spindash()
{
	gml_pragma("forceinline");
	
	if !global.spin_dash
	{
		exit;
	}

	// Spin Dash initiation logic
	if action != ACTION_SPINDASH
	{
		if action == ACTION_NONE && (animation == ANI_DUCK || animation == ANI_GLIDE_LAND)
		{
			if !input_press.action_any || !input_down.down
			{
				return false;
			}
		
			animation = ANI_SPINDASH;
			action = ACTION_SPINDASH;
			spindash_charge = 0;
			spindash_pitch = 1;
			vel_x = 0;
			vel_y = 0;
			
			instance_create(0, 0, obj_dust_spindash, { TargetPlayer: id });
			audio_play_sfx(sfx_charge);
		}
		
		return false;
	}

	// Charge Spin Dash
	if input_down.down
	{
		if !input_press.action_any
		{
			spindash_charge -= floor(spindash_charge / 0.125) / 256;
			exit;
		}
	
		spindash_charge = min(spindash_charge + 2, 8);
	
		if audio_is_playing(sfx_charge) && spindash_charge > 0
		{
			spindash_pitch = min(spindash_pitch + 0.1, 1.5);
		}
		else
		{
			spindash_pitch = 1;
		}
	
		var _sound = audio_play_sfx(sfx_charge);
		audio_sound_pitch(_sound, spindash_pitch);
		ani_update_frame(0);
		
		return false;
	}
	
	// Release Spin Dash
	var _min_speed = 8;
	var _speed = (super_timer > 0 ? 11 : _min_speed) + round(spindash_charge) / 2;
	var _raw_camera_delay = -((_speed - _min_speed) * 2) + 32;
	
	m_player_set_camera_delay(floor(_raw_camera_delay / 2));
	
	y += radius_y - radius_y_spin;	
	radius_x = radius_x_spin;
	radius_y = radius_y_spin;
	animation = ANI_SPIN;
	action = ACTION_NONE;
	spd_ground = _speed * facing;

	if global.fix_dash_release
	{
		m_player_set_velocity_from_speed();
	}

	audio_stop_sound(sfx_charge);
	audio_play_sfx(sfx_release);
	
	// Exit the player control routine
	return true;
}