/// @description Setup
// You can write your code in this editor
	
	if !global.RichPresenceSupport
	{
		// Remove controller if Rich Presence is disabled
		instance_destroy(); return;
	}
	
	np_clearpresence();
	
	// Setup Script
	DiscordSetup();
