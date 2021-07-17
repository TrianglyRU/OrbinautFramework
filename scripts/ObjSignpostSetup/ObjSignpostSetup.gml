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
			SpriteEnd	= spr_obj_signpost_start_sonic;
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
}