function ObjComboScoreStartup()
{
	// Set blank values
	ComboTrigger = 0;
	SpriteFrame  = 0;
	PointsGiven  = 0;
	
	// Set other variables
	Ysp	 = -3;
	PosY = y;
	
	// Set object depth
	object_set_depth(Player, true);
}