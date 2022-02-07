function ObjWaterSplashStartup()
{
	// Set object properties
	object_set_depth(Player, 1);
	animation_play(sprite_index, 4, 7);
}