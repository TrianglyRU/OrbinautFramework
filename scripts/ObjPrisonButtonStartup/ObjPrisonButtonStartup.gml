function ObjPrisonButtonStartup()
{
	State = 0;
	
	// Set object properties
	object_set_solidbox(12, 8, false);
	animation_play(sprite_index, 3, 0);
}