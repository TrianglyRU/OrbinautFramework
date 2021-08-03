function ObjSignpostSetup()
{
	// Initialize variables
	Active	    isVar;
	ActiveTimer isVar;
	SpriteStart isVar;
	SpriteEnd	isVar;
	
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
			SpriteStart = spr_obj_signpost_start_sonic;
			SpriteEnd	= spr_obj_signpost_end_sonic;
		break;
		case CharTails:
			SpriteStart = spr_obj_signpost_start_tails;
			SpriteEnd	= spr_obj_signpost_end_tails;
		break;
		case CharKnuckles:
			SpriteStart = spr_obj_signpost_start_knuckles;
			SpriteEnd	= spr_obj_signpost_end_knuckles;
		break;
	}
	
	// Sparkle position data
	SparkleToUse = 0;
	SparkleX	 = [-24, 8, -16, 24, 0, 16, -24, 24];
	SparkleY	 = [-16, 8, 0, -8, -8, 0, 8, 16];	
}