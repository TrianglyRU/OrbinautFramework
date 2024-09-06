/// @function scr_giganorbi_health_updater
function scr_giganorbi_health_updater()
{
	gml_pragma("forceinline");
	
	if !visible
	{
		exit;
	}

	// Handle boss invincibility frames
	var _black_id = 13;
	
	if boss_inv_frames > 0
	{
		if --boss_inv_frames != 0
		{
			pal_set_index([_black_id], pal_get_index(_black_id) == 2 ? 1 : 2);
			exit;
		}
		
		image_index = boss_state == BOSS_GIGAN_STATE_BOUNCE ? 1 : 0;
		pal_set_index([_black_id], 1);
		
		exit;
	}

	// Act as a boss and exit if not hit
	if obj_act_enemy(ENEMYTYPE.BOSS)
	{
		exit;
	}
	
	if --boss_hp > 0
	{
		boss_inv_frames = 64; // Usually this is 32 frames, but it's more fair for this boss
		image_index = 2;
		audio_play_sfx(sfx_boss_hit);
		pal_set_index([_black_id], 2);
	}
	
	// Process defeat sequence
	else
	{
		for (var i = 0; i < orb_count; i++)
		{
			var _orb = orbs[i];
		
			if _orb == noone
			{
				continue;
			}
		
			_orb.ParentBoss = noone;
		}

		boss_target.m_player_add_score(4);
		instance_create(x, y, obj_giganorbi_defeated, { image_xscale: image_xscale });
		instance_destroy();
	}
}
