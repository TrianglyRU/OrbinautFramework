function ObjWaterSplashStartup()
{
	// Set object properties
	object_set_depth(Player, 1);
	animation_play(spr_obj_watersplash, 4, 0, 7);
}