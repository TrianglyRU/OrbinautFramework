/// @self obj_player
function scr_player_hammer_spin()
{
	if action != ACTION.HAMMER_SPIN
	{
		return;
	}
	
	if is_grounded && dropdash_charge >= PARAM_DROPDASH_CHARGE
	{
		animation = ANIM.HAMMER_DASH;
		action = ACTION.HAMMER_DASH;
		hammer_dash_timer = 0;

		if super_timer > 0 && player_index == camera_data.index
		{
			camera_data.shake_timer = 6;
		}
		
		// Start hammer_dash
		scr_player_hammer_dash();
		
		audio_stop_sound(snd_drop_dash);
		audio_sfx_play(snd_spin_release);
		
		return;
	}
	
	if input_down_action_any()
	{
		if dropdash_charge >= 0
		{
			if ++dropdash_charge == PARAM_DROPDASH_CHARGE
			{
				audio_sfx_play(snd_drop_dash);
			}
		}
	
		air_lock_flag = false;
	}
	else if dropdash_charge > 0
	{
		dropdash_charge = dropdash_charge >= PARAM_DROPDASH_CHARGE ? -1 : 0;
	}
}
