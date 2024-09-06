/// @function scr_player_update_status
function scr_player_update_status()
{
	gml_pragma("forceinline");

	// Skid effect handling
	if animation == ANI_SKID
	{
		if skid_timer++ % 4 == 0
		{
			instance_create(x, y + radius_y, obj_dust_skid);
		}
	}

	// Invincibility frames handling
	if inv_frames > 0
	{
		image_alpha = (inv_frames & 4 > 0) * 1.0;
		if --inv_frames == 0
		{
			image_alpha = 1.0;
		}
	}

	// Power Sneakers power-up
	if item_speed_timer > 0
	{
		if --item_speed_timer == 0 && audio_is_playing(bgm_highspeed)
		{
			audio_reset_bgm(c_stage.bgm_track, id);
		}
	}

	// Invincibility power-up
	if item_inv_timer > 0
	{
		if --item_inv_timer == 0 && audio_is_playing(bgm_invincibility)
		{
			audio_reset_bgm(c_stage.bgm_track, id);
		}
	}
	
	// Super Form and transformation
	if super_timer > 0
	{
		if action == ACTION_TRANSFORM
		{
			if --transform_timer == 0
			{
				state = PLAYER_STATE_CONTROL;
				m_player_reset();
				instance_create(x, y, obj_star_super, { TargetPlayer: id });
			}
		}
	
		if super_timer == 1
		{
			if --global.player_rings <= 0
			{
				global.player_rings = 0;
				inv_frames = 1;
				super_timer = 0;
				
				if !audio_is_playing(bgm_drowning)
				{
					audio_reset_bgm(c_stage.bgm_track, id);
				}
			}
			else
			{
				super_timer = 61;
			}
		}
		else
		{
			super_timer--;
		}
	}
	
	// Time over
	if c_framework.frame_counter == 36000 && player_index == 0
	{
		m_player_kill();
	}
}