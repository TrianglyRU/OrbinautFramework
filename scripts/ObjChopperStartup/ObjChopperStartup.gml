function ObjChopperStartup()
{
	// Initialise variables
	OriginY =  y;
	PosY    =  y;
	Ysp		= -7;
	State   =  0;
	
	// Set object properties
	object_set_hitbox(12, 16);
	object_set_unload(TypeReset);
	object_set_depth(Player, 0);
	animation_play(sprite_index, 8, 0, 0);
}