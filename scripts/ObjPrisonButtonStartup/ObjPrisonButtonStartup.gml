function ObjPrisonButtonStartup()
{
	// Set variable
	State = 0;
	
	// Set object solidbox
	object_set_solidbox(12, 8, false);
	
	// Set object depth
	object_set_depth(EggPrison, 0);
	
	// Set animation
	animation_play(sprite_index, 3, 0, 0);
}