function ObjWaterSplashStartup()
{
	// Set object depth
	object_set_depth(Player, 1);
	
	// Set animation
	animation_play(spr_obj_watersplash, 4, 0, 7);
}