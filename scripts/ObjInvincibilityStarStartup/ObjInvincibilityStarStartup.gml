function ObjInvincibilityStarStartup()
{
	// Set blank values
	AngleOffset = 0;
	Angle		= 0;
	ID			= 0;
	
	// Set frame data
	FrameValue  = [0, 0];
	FrameTable1 = [0, 0, 1, 2, 3, 4, 5, 4, 3, 2, 1, 0, 0, 0, 1, 2, 3, 4, 5, 4, 3, 2, 1, 0];
	FrameTable2 = [0, 1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1];
	FrameTable3 = [1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1, 2, 3, 4, 5, 6, 5, 4, 3, 2];
	FrameTable4 = [6, 3, 5, 3, 3, 5, 3, 6, 3, 5, 5, 3];

	// Set object depth
	object_set_depth(Player, 1);
}