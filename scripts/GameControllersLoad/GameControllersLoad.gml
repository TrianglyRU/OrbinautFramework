function GameControllersLoad()
{
	// Exit if room is the start one
	if room == Screen_Startup
	{
		exit;
	}
	
	// Create additional main controllers
	instance_create(x, y, Audio);
	instance_create(x, y, Input);
	instance_create(x, y, Palette);
	instance_create(x, y, Camera);
	
	// Create discord controller
	if Game.RichPresenceSupport
	{
		instance_create(x, y, Discord);
	}
}