function ObjRingSetup()
{	
	// Create variables
	PosX		   _init;
	PosY		   _init;
	Xsp			   _init;
	Ysp			   _init;
	Grv			   _init;
	Timer		   _init;
	Physical       _init;
	CollisionCheck _init;
	PickupTimeout  _init;
	
	// Set object hitbox
	object_set_hitbox(6, 6);
	
	// Set object visibility
	object_set_visibility(true);
	
	// Render behind the player
	object_set_depth(Player, false);
	
	// Set default values
	PosX     = x;
	PosY     = y;
	Timer    = 256;
	Grv      = 0.09375;
	Physical = false;
}