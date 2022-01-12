function ObjClearPanelStartup()
{
	/* Variable Definitions	
	1. PlayerType, default = "All"					
	*/
	
	// Initialsie variables
	State	     = 0;
	StateTimer   = 0;
	SparkleToUse = 0;
	
	switch Game.Character
	{
		case CharSonic:
		{
			SpriteData[0] = spr_obj_clearpanel_start_st;
			SpriteData[1] = spr_obj_clearpanel_end_s;
		}
		break;
		case CharTails:
		{
			SpriteData[0] = spr_obj_clearpanel_start_st;
			SpriteData[1] = spr_obj_clearpanel_end_t;
		}
		break;
		case CharKnuckles:
		{
			SpriteData[0] = spr_obj_clearpanel_start_k;
			SpriteData[1] = spr_obj_clearpanel_end_k;
		}
		break;
	}
	sprite_index = SpriteData[0];
	
	// Sparkle position table
	SparkleX = [-24, 8, -16, 24, 0, 16, -24, 24];
	SparkleY = [-16, 8, 0, -8, -8, 0, 8, 16];
	
	// Set object properties
	object_set_depth(Player, 0);
}