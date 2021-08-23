function ObjLedgePieceStartup()
{
	// Create varaibles
	PosY  = 0;
	Ysp   = 0;
	Timer = 0;
	DrawX = 0;
	DrawY = 0;
	
	// Set default position
	PosY = y;
	
	// Set object active range
	object_set_range(RangeFar, TypeDelete);
}