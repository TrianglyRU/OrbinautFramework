function ObjWaterSplashMain()
{
	// Play animation
	animation_play(spr_obj_watersplash, 4, 7);
	
	// Destroy on animation end
	if image_index == 7
	{
		instance_destroy();
	}
}