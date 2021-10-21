function ObjPrisonButtonStartup()
{
	// Set variable
	State = 0;
	
	// Set object solidbox
	object_set_solidbox(12, 8, false);
	
	// Set object depth
	object_set_depth(EggPrison, false);
	
	// Set animation
	animation_set(sprite_index, 3, 0, 0);
}