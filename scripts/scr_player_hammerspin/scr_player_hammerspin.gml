/// @function scr_player_hammerspin
function scr_player_hammerspin()
{
	gml_pragma("forceinline");

	if action != ACTION_HAMMERSPIN
	{
		exit;
	}

	// Perform Hammer Dash on landing if charge is sufficient (called by m_player_land())
	if is_grounded && dropdash_charge >= PARAM_DROPDASH_CHARGE
	{
		animation = ANI_HAMMERDASH;
		action = ACTION_HAMMERDASH;
		hammerdash_timer = 0;

		if super_timer > 0 && player_index == camera_data.index
		{
			camera_data.shake_timer = 6;
		}
	
		scr_player_hammerdash();
		audio_stop_sound(sfx_charge3);
		audio_play_sfx(sfx_release);
		
		exit;
	}

	// Manage Hammer Spin charge based on input
	if input_down.action_any
	{
		if ++dropdash_charge == PARAM_DROPDASH_CHARGE
		{
			audio_play_sfx(sfx_charge3);
		}
	
		air_lock_flag = false;
	}
	else if dropdash_charge > 0
	{
		if dropdash_charge >= PARAM_DROPDASH_CHARGE
		{
			animation = ANI_SPIN;
			action = ACTION_HAMMERSPIN_C;
		}
	
		dropdash_charge = 0;
	}
}
