function ObjComboScoreStartup()
{
	// Variables list
	ComboFrame = 0;
	ScoreFrame = 0;
	PosY	   = 0;
	Ysp	       = 0;
	
	// Render above player
	object_set_depth(Player, true);
	
	// Set default position and speed
	PosY =  y;
	Ysp  = -3;
	
	// Set flag
	ComboFrame = true;
}