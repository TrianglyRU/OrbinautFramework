function ObjComboScoreStartup()
{
	// Initialize variables
	ScoreFrame isReal;
	PosY	   isReal;
	Ysp	       isReal;
	
	// Render above player
	object_set_depth(Player, true);
	
	// Set default position and speed
	PosY =  y;
	Ysp  = -3;
}