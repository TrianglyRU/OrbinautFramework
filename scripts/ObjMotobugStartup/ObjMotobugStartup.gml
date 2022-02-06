function ObjMotobugStartup()
{
	PosX	   = x;
	PosY	   = y;
	Ysp		   = 0;
	State	   = 0;
	StateTimer = 0;
	
	// Set object properties
	object_set_unload(TypeReset);
	object_set_depth(Player, 0);
	object_set_hitbox(20, 17);
}