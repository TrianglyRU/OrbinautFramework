/// @description
// You can write your code in this editor
	
	// Framework Scripts
	#region Framework
	{
		// Call macro initialization script
		GameMacro();
	
		// Call variables initialization script
		GameVariables();
	
		// Call framework setup script
		GameFrameworkSetup();
	
		// Call fonts setup script
		GameFontsSetup();
	
		// Call music startup script
		GameAudioStartup();
	
		// Call shaders startup script
		GameShadersStartup();

		// Call window startup script
		GameWindowStartup();
	
		// Call data load script
		GameDataLoad();
	}
	#endregion
	
	// Discord Scripts
	#region Discord
	{
		// Call startup script
		DiscordStartup();
	}
	#endregion