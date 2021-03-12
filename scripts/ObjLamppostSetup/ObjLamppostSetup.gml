function ObjLamppostSetup()
{
	// Set object collision type
	object_set_collision(SolidNone);
	
	// Set object hitbox
	object_set_hitbox(8, 32);
	
	// Set object visibility
	object_set_visibility(true);
		
	// Render behind the player
	object_set_depth(Player, false);
	
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