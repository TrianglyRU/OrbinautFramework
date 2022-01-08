function GameTimeProcess()
{
	// Process global timer
	if !fade_check(StateActive) and !variable_check(Stage, "IsPaused")
	{
		Game.GlobalTime++;
	}
	
	// Create data structure
	if !ds_exists(Game.SpriteTimers, ds_type_map)
	{
		Game.SpriteTimers = ds_map_create();
	}
}