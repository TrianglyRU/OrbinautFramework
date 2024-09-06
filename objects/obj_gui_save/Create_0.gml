// Destroy any existing save icons
with obj_gui_save if id != other.id
{
	instance_destroy();
}

timer = 0;

switch global.player_main
{
	case PLAYER_TAILS:
		sprite_index = spr_obj_gui_save_tails;
	break;
	
	case PLAYER_KNUCKLES:
		sprite_index = spr_obj_gui_save_knuckles;
	break;
	
	case PLAYER_AMY:
		sprite_index = spr_obj_gui_save_amy;
	break;
}