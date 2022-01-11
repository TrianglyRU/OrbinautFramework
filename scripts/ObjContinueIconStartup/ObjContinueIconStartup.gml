function ObjContinueIconStartup()
{
	// Define icon sprite
	switch Game.Character
	{
		case CharSonic:
			sprite_index = gui_icon_sonic;
		break;
		case CharTails:
			sprite_index = gui_icon_tails;
		break;
		case CharKnuckles:
			sprite_index = gui_icon_knuckles;
		break;
	}
	
	// Set animation
	animation_play(sprite_index, 16, 0, 0);
}