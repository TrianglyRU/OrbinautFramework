function ObjStarPostStartup()
{
	// Create variables
	Active = 0;
	Angle  = 0;
	
	/* Variable Definitions	
	1. ID, default = 0		
	*/
	
	// Set object triggerbox
	object_set_triggerbox(-8, 8, -52, 52);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Load as activated if ID is lower than the ID of activated one
	if Game.StarpostID != false and Game.StarpostID.ID >= ID
	{
		animation_set(spr_obj_starpost_active, 1);
		
		Active = true;
		Angle  = 900;
	}
	else
	{
		// Set default lamp angle
		Angle = 180;
	}
}