function ObjRingSetup()
{	
	// Initialize variables
	PosX		   isVar;
	PosY		   isVar;
	Xsp			   isVar;
	Ysp			   isVar;
	Grv			   isVar;
	Timer		   isVar;
	Physical       isVar;
	Magnetized     isVar;
	CollisionCheck isVar;
	PickupTimeout  isVar;
	
	// Set object hitbox
	object_set_hitbox(6, 6);
	
	// Render behind the player
	object_set_depth(Player, false);
	
	// Set default position
	PosX     = x;
	PosY     = y;
	
	// Set default values
	Timer    = 256;
	Grv      = 0.09375;
}