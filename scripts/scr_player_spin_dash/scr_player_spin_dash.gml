/// @self obj_player
function scr_player_spin_dash()
{
	if !global.spin_dash
	{
		return false;
	}
	
	if action != ACTION.SPIN_DASH
	{
		if action == ACTION.NONE && (animation == ANIM.DUCK || animation == ANIM.GLIDE_LAND)
		{
			if !input_down.down || !input_press_action_any()
			{
				return false;
			}
			
			animation = ANIM.SPIN_DASH;
			action = ACTION.SPIN_DASH;
			spin_dash_charge = 0;
			spin_dash_pitch = 1;
			vel_x = 0;
			vel_y = 0;
			
			with instance_create(x, y + radius_y, obj_spin_dash_dust)
			{
				player = other.id;
			}
			
			audio_sfx_play(snd_spin_charge);
		}
		
		return false;
	}
	
	if input_down.down
	{
		if spin_dash_charge > 0
		{
			spin_dash_charge -= floor(spin_dash_charge / 0.125) / 256;
		}
		
		if input_press_action_any()
		{
			animator.restart();
			spin_dash_charge = min(spin_dash_charge + 2, 8);
			
			if spin_dash_charge > 0 && audio_is_playing(snd_spin_charge)
			{
				spin_dash_pitch = min(spin_dash_pitch + 0.1, 1.5);
			}
			else
			{
				spin_dash_pitch = 1;
			}
			
			audio_sound_pitch(audio_sfx_play(snd_spin_charge), spin_dash_pitch);
		}
		
		return false;
	}
	
	var _min_speed = 8;
	var _speed = (super_timer > 0 ? 11 : _min_speed) + round(spin_dash_charge) * 0.5;
	var _raw_camera_delay = -((_speed - _min_speed) * 2) + 32;
	
	y += radius_y - radius_y_spin;	
	radius_x = radius_x_spin;
	radius_y = radius_y_spin;
	animation = ANIM.SPIN;
	action = ACTION.NONE;
	spd = _speed * facing;
	
	set_camera_delay(floor(_raw_camera_delay * 0.5));
	set_velocity();
	
	audio_stop_sound(snd_spin_charge);
	audio_sfx_play(snd_spin_release);
	
	// Exit the player control routine
	return true;
}