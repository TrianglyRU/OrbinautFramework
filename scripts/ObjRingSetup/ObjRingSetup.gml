function ObjRingSetup()
{	
	PosX  = 0;
	PosY  = 0;
	Xsp   = 0;
	Ysp   = 0;
	Grv   = 0.09375;
	Timer = 256
	
	Physical = false;
	CollisionCheck = 0;
	PickupTimeout = 0;
	
	// Set object hitbox
	object_set_hitbox(6, 6);
	
	// Set object visibility
	object_set_visibility(true);
	
	// Render behind the player
	object_set_depth(Player, false);
}