/// @description Restart Room
if global.dev_mode
{
	if instance_exists(obj_rm_stage)
	{
		game_clear_level_data_all();
	}
	
	room_restart();
}