function GameInstancesStartup()
{
	// Initalise system variables for all instances that do not have them
	with all
	{
		instance_initialise();
	}
}