function ObjProjectileStartup()
{
	// Set blank values
	Xsp   = 0;
	Ysp   = 0;
	State = 0;
	
	// Set other variables
	PosX = x;
	PosY = y;
	Grv  = 0.21875;
	
	// Set object hitbox
	object_set_hitbox(6, 6);
	
	// Set object unload type
	object_set_unload(TypeDelete);
	
	// Set animation
	animation_play(sprite_index, 2, 0, 0);
}