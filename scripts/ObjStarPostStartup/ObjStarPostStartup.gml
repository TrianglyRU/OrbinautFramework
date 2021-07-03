function ObjStarPostStartup()
{
	// Create variables
	Active isBool;
	Angle  isReal;
	
	/* Variable Definitions	
	1. ID, default = 0		
	*/
	
	// Set triggerbox
	object_set_triggerbox(-8, 8, -52, 52);
	
	// Render behind the player
	object_set_depth(Player, false);
	
	// Set default lamp angle
	Angle = 180;
	
	// Load as activated if ID is lower than the ID of activated one
	if Game.CheckpointID != 0 and Game.CheckpointID.ID >= ID
	{
		animation_set_frame(sprite_index, 3);
		Active = true;
		Angle  = 900;
	}
}