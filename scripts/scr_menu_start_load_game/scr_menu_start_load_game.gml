/// @self obj_rm_dev_menu
function scr_menu_start_load_game()
{
	var _new_game_stage = rm_stage_ghz_1;
	
	if game_check_data(global.current_save_slot) == SAVE_DATA_STATE.EMPTY
	{
		return _new_game_stage;
	}
	
	game_load_data(global.current_save_slot);
	game_clear_level_data_all();
	
	switch global.game_progress_flag
	{
		// Load into the stage that follows the one we completed last
		case GAME_PROGRESS_GHZ:
			room_goto(rm_stage_ehz_1);
		break;
		
		case GAME_PROGRESS_MAX:
			room_goto(rm_level_select);
		break;
		
		default:
			room_goto(_new_game_stage);
	}
	
	return undefined;
}