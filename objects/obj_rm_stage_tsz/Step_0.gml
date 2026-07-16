// Inherit the parent event
event_inherited();

if obj_game.state != GAME_STATE.STOP_ALL
{
	if FRAME_COUNTER % 6 == 0
	{
		pal_set_index([36], irandom_range(1, 3));
	}
	
	with obj_parallax
	{
		if sprite_index == spr_bg_tsz_10
		{
			scale_target_y = obj_water.y; break;
		}
	}
}