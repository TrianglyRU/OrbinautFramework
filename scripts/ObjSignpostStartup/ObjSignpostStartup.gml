function ObjSignpostStartup()
{
	// Create variables
	State	     = 0;
	StateTimer   = 0;
	SparkleToUse = 0;
	
	/* Variable Definitions	
	1. PlayerType, default = "All"					
	*/
	
	// Set sparkle position data
	SparkleX = [-24, 8, -16, 24, 0, 16, -24, 24];
	SparkleY = [-16, 8, 0, -8, -8, 0, 8, 16];
	
	// Set sprites
	switch Game.Character
	{
		case CharSonic:
		{
			SpriteData[0] = spr_obj_signpost_start_sonic;
			SpriteData[1] = spr_obj_signpost_end_sonic;
		}
		break;
		case CharTails:
		{
			SpriteData[0] = spr_obj_signpost_start_tails;
			SpriteData[1] = spr_obj_signpost_end_tails;
		}
		break;
		case CharKnuckles:
		{
			SpriteData[0] = spr_obj_signpost_start_knuckles;
			SpriteData[1] = spr_obj_signpost_end_knuckles;
		}
		break;
	}
	sprite_index = SpriteData[0];
	
	// Set object triggerbox
	object_set_triggerbox(0, 32, -512, 512);
		
	// Set object depth
	object_set_depth(Player, false);
}