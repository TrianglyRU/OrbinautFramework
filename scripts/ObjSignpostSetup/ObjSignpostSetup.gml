function ObjSignpostSetup()
{
	// Initialize variables
	Active	     = 0;
	ActiveTimer  = 0;
	SparkleToUse = 0;
	SparkleX	 = [];
	SparkleY	 = [];
	SpriteData   = [];
	
	/* Variable Definitions	
	1. PlayerType, default = "All"					
	*/
	
	// Set object triggerbox
	object_set_triggerbox(0, 32, -512, 512);
		
	// Set object depth
	object_set_depth(Player, false);
	
	// Get sprite
	switch Player.CharacterID
	{
		case CharSonic:
			SpriteData[0] = spr_obj_signpost_start_sonic;
			SpriteData[1] = spr_obj_signpost_end_sonic;
		break;
		case CharTails:
			SpriteData[0] = spr_obj_signpost_start_tails;
			SpriteData[1] = spr_obj_signpost_end_tails;
		break;
		case CharKnuckles:
			SpriteData[0] = spr_obj_signpost_start_knuckles;
			SpriteData[1] = spr_obj_signpost_end_knuckles;
		break;
	}
	
	// Sparkle position data
	SparkleX	 = [-24, 8, -16, 24, 0, 16, -24, 24];
	SparkleY	 = [-16, 8, 0, -8, -8, 0, 8, 16];	
}