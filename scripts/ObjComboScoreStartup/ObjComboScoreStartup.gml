function ObjComboScoreStartup()
{
	// Variables list
	ScoreFrame = 0;
	PosY	   = 0;
	Ysp	       = 0;
	
	// Render above player
	object_set_depth(Player, true);
	object_set_range(RangeClose, 2);
	
	// Set default position and speed
	PosY =  y;
	Ysp  = -3;
}