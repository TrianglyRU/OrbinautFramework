function ObjBuzzbomberBulletStartup()
{
	// Create variables
	Xsp   = 0;
	Ysp   = 0;
	Timer = 0;
	
	// Set object hitbox
	object_set_hitbox(4, 4);
	
	// Set object active range
	object_set_range(TypeDelete);
}