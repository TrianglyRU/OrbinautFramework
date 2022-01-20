function GameInstancesStartup()
{
	// Initalise system variables for all instances that do not have them
	with all
	{
		instance_initialise();
	}
	
	// Create data structure for animation timers
	if !ds_exists(Game.AnimationTime, ds_type_map)
	{
		Game.AnimationTime = ds_map_create();
	}
	ds_map_add(Game.AnimationTime, GlobalTime, 0);
}