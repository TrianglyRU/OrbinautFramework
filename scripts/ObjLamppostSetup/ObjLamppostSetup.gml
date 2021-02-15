function ObjLamppostSetup()
{
	// Init lamppost
	Active = false;
	Angle  = 180;
	
	// Load as activated if its ID number is lower than activated one
	if Game.SavedCheckpoint != 0 and Game.SavedCheckpoint.LamppostID >= LamppostID
	{
		image_index = 2;
		Active      = true;
		Angle		= 900;
	}
	
	// Render behind the player
	object_set_depth(false);
}