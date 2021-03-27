/// @description Game Startup
// You can call your scripts in this editor. One-time initial
	
	// Initialize the framework
	GameMacroSetup();
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
	// gamesettings_load("config");