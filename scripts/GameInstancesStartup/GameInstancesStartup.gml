function GameInstancesStartup()
{
	// Initalise system variables for all instances that do not have them at this moment
	with all
	{
		instance_initialise();
	}
}