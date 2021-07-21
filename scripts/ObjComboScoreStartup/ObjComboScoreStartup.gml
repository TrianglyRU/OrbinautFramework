function ObjComboScoreStartup()
{
	// Initialize variables
	ScoreFrame isReal;
	PosY	   isReal;
	Ysp	       isReal;
	
	// Render above player
	object_set_depth(Player, true);
	object_set_range(RangeClose, 2);
	
	// Set default position and speed
	PosY =  y;
	Ysp  = -3;
}