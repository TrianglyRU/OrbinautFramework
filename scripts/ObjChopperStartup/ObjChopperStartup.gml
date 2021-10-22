function ObjChopperStartup()
{
	// Set default position and speed
	OriginY = y;
	PosY    = y;
	Ysp		= -7;
	
	// Set object hitbox
	object_set_hitbox(12, 16);
	
	// Set object unload type
	object_set_unload(TypeReset);
	
	// Set animation
	animation_play(sprite_index, 8, 0, 0);
}