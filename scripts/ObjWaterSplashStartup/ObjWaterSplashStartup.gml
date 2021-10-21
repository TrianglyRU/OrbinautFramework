function ObjWaterSplashStartup()
{
	// Set object depth
	object_set_depth(Player, true);
	
	// Set animation
	animation_set(spr_obj_watersplash, 4, 0, 7);
}