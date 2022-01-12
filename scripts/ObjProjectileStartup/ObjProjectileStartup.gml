function ObjProjectileStartup()
{
	// Initialise variables
	PosX  = x;
	PosY  = y;
	Xsp   = 0;
	Ysp   = 0;
	Grv   = 0.21875;
	State = 0;
	
	// Set object properties
	object_set_hitbox(6, 6);
	object_set_unload(TypeDelete);
	animation_play(sprite_index, 2, 0, 0);
}