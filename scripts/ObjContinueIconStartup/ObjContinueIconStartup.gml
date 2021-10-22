function ObjContinueIconStartup()
{
	// Define icon sprite
	switch Game.Character
	{
		case CharSonic:
			sprite_index = spr_obj_conticon_sonic;
		break;
		case CharTails:
			sprite_index = spr_obj_conticon_tails;
		break;
		case CharKnuckles:
			sprite_index = spr_obj_conticon_knuckles;
		break;
	}
	
	// Set animation
	animation_play(sprite_index, 16, 0, 0);
}