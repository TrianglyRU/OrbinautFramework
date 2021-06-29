/// @description Scripts Event
// You can call your scripts in this editor
	
	// Initialize variables
	ScoreFrame isVar;
	PosY	   isVar;
	Ysp	       isVar;
	
	// Render above player
	object_set_depth(Player, true);
	
	// Set default position and speed
	PosY =  y;
	Ysp  = -3;