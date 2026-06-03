/// @function scr_giganorbi_health_updater
function scr_giganorbi_health_updater()
{
	if !visible
	{
		return;
	}
	
	var _black_id = 255;
	
	if boss_inv_frames > 0
	{
		if --boss_inv_frames != 0
		{
			pal_set_index([_black_id], pal_get_index(_black_id) == 2 ? 1 : 2);
		}
		else 
		{
			pal_set_index([_black_id], 1);
			image_index = boss_state == GIGANORBI_STATE.BOUNCE ? 1 : 0;
		}
		
		return;
	}
	
	var _player = react_to_players(REACT_TYPE.BOSS);
	
	if _player == noone
	{
		return;
	}
	
	if --boss_hp > 0
	{
		boss_inv_frames = 64;
		image_index = 2;
		
		audio_sfx_play(snd_boss_hit);
		pal_set_index([_black_id], 2);
	}
	else
	{
		for (var _i = 0; _i < orb_count; _i++)
		{
			var _orb = orbs[_i];
		
			if _orb != noone
			{
				_orb.parent_boss = noone;
			}
		}
		
		boss_target.add_score(4);
		
		instance_create(x, y, obj_giganorbi_defeated, { image_xscale: image_xscale });
		instance_destroy();
	}
}