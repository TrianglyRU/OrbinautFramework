/// @description Startup
// You can write your code in this editor
	
	/* This object isn't used during the Results,
	the sprite is drawn instead */
	
	switch global.Character
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
	animation_play(sprite_index, 16, 0);