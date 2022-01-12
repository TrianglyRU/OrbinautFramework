function ObjExplosionSetup()
{
	// Set object properties
	object_set_depth(Player, 1);
	animation_play(sprite_index, [6, 8, 8, 8, 8, 0], 0, 5);
}