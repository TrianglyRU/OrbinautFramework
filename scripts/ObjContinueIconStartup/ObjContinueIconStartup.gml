function ObjContinueIconStartup()
{
	// Define icon sprite
	switch Game.Character
	{
		case CharSonic:
			sprite_index = spr_obj_cont_sonic_wait;
		break;
		case CharTails:
			sprite_index = spr_obj_cont_tails_wait;
		break;
		case CharKnuckles:
			sprite_index = spr_obj_cont_knux_wait;
		break;
	}
	
	// Set animation
	animation_play(sprite_index, 16, 0, 0);
}