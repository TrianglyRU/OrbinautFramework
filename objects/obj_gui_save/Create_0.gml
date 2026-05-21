// Inherit the parent event
event_inherited();

max_allowed_game_state = GAME_STATE.STOP_ALL;
timer = 0;

switch global.player_main
{
	case PLAYER.TAILS:
		sprite_index = spr_gui_save_tails;
	break;
	
	case PLAYER.KNUCKLES:
		sprite_index = spr_gui_save_knuckles;
	break;
	
	case PLAYER.AMY:
		sprite_index = spr_gui_save_amy;
	break;
}

with obj_gui_save
{
	if id != other.id
	{
		instance_destroy();
	}
}