/// @description Startup
// You can write your code in this editor
	
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
	animation_play(sprite_index, room == Screen_Continue ? 16 : 8, 0);