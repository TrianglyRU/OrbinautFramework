function ObjCrabmeatBulletStartup()
{
	// Create default variables
	PosX = 0;
	PosY = 0;
	Xsp  = 0;
	Ysp  = 0;
	
	// Set default position
	PosX = x;
	PosY = y;
	Ysp  = -4;

	// Set object hitbox
	object_set_hitbox(4, 4);
	
	// Set object unload type
	object_set_unload(TypeDelete);
}