function GameInstancesStartup()
{
	// Initalise system variables for all instances that do not have them
	with all
	{
		instance_initialise();
	}
	
	// Create data structure for animation timers
	Game.AnimationTime = ds_map_create();
	Game.AnimationTime[? GlobalTime] = 0;
}