function ObjComboScoreStartup()
{
	// Variables list
	ComboTrigger = 0;
	SpriteFrame  = 0;
	PointsGiven  = 0;
	PosY	     = 0;
	Ysp	         = 0;
	
	// Render above player
	object_set_depth(Player, true);
	
	// Set default position and speed
	PosY =  y;
	Ysp  = -3;
}