function ObjWaterSplashScript()
{
	// Set object depth
	object_set_depth(Player, true);
	
	// Play animation
	animation_play(spr_obj_watersplash, 4, 8);
	
	// Destroy on animation end
	if animation_get_frame(id) == 8
	{
		instance_destroy();
	}
}