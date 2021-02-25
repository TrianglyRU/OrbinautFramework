function ObjLamppostSetup()
{
	// Set instance as interactive object
	object_initialize(SolidNone);
	
	// Set object hitbox
	object_set_hitbox(8, 32);
	
	// Render behind the player
	object_set_depth(false);
	
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
}