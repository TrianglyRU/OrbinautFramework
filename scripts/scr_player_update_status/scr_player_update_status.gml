/// @self obj_player
function scr_player_update_status()
{
	if animation == ANIM.SKID
	{
		if skid_timer++ % 4 == 0
		{
			instance_create(x, y + radius_y, obj_skid_dust);
		}
	}

	if inv_frames > 0
	{
		image_alpha = (inv_frames & 4 > 0) * 1;
		
		if --inv_frames == 0
		{
			image_alpha = 1;
		}
	}

	if item_speed_timer > 0 && --item_speed_timer == 0
	{
		if (audio_is_playing(snd_bgm_high_speed) || !audio_bgm_is_playing()) && instance_exists(obj_rm_stage)
		{
			restart_bgm(obj_rm_stage.bgm_track);
		}
	}

	if item_inv_timer > 0 && --item_inv_timer == 0
	{
		if (audio_is_playing(snd_bgm_invincibility) || !audio_bgm_is_playing()) && instance_exists(obj_rm_stage)
		{
			restart_bgm(obj_rm_stage.bgm_track);
		}
	}
	
	if super_timer > 0
	{
		if action == ACTION.TRANSFORM
		{
			if --transform_timer == 0
			{
				state = PLAYER_STATE.DEFAULT;
				reset_substate();
				
				with instance_create(x, y, obj_super_star)
				{
					player = other.id;
				}
			}
		}
	
		if super_timer == 1
		{
			if --global.player_rings <= 0
			{
				global.player_rings = 0;
				inv_frames = 1;
				super_timer = 0;
				
				if !audio_is_playing(snd_bgm_drowning) && instance_exists(obj_rm_stage)
				{
					restart_bgm(obj_rm_stage.bgm_track);
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
	
	if FRAME_COUNTER == 36000 && player_index == 0
	{
		kill();
	}
}