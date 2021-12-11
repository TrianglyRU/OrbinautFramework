function GameControllersLoad()
{
	// Create Discord contoller (it will be deleted if RP support is disabled)
	instance_create(x, y, Discord);
	
	// Exit if room current room is the startup one
	if room == Screen_Startup
	{
		exit;
	}
	
	// Create additional main controllers
	instance_create(x, y, Audio);
	instance_create(x, y, Input);
	instance_create(x, y, Palette);
	instance_create(x, y, Camera);
}