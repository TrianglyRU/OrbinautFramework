/// @description Game Startup
// You can call your scripts in this editor. One-time initial
	
	// Initialize macros and global variables
	_GameMacros();
	_GameVariables();
	
	// Initialize framework settings
	GameFrameworkSetup();
	
	// Initialize audio
	GameAudioGroupsLoad();
	
	// Initialize fonts
	GameFontsSetup();

	// Initialize shaders
	GameShadersSetup();
	
	// Initialize application window
	GameWindowSetup();
	
	// Load game settings
	gamesettings_load("config");