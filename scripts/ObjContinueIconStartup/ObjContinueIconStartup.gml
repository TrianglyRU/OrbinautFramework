function ObjContinueIconStartup()
{
	// Variables list
	IconSprite = 0;
	
	// Define icon sprite
	switch Game.Character
	{
		case CharSonic:
			IconSprite = spr_obj_conticon_sonic;
		break;
		case CharTails:
			IconSprite = spr_obj_conticon_tails;
		break;
		case CharKnuckles:
			IconSprite = spr_obj_conticon_knuckles;
		break;
	}
	
	// Apply icon
	animation_set_frame(IconSprite, 1);
}