// Inherit the parent event
event_inherited();
event_animator();

switch global.player_main
{
	case PLAYER.TAILS:
		sprite_index = spr_gui_continue_tails;
	break;
	
	case PLAYER.KNUCKLES:
		sprite_index = spr_gui_continue_knuckles;
	break;
	
	case PLAYER.AMY:
		sprite_index = spr_gui_continue_amy;
	break;
}

animator.start(sprite_index, 0, 0, 20);