/// @description Game Startup
// You can call your scripts in this editor
	
	// Initialize macros and global variables
	GameMacro();
	GameVariables();
	
	// Initialize framework settings
	GameFrameworkSetup();
	
	// Load game settings and tile data
	GameDataLoad();
	
	// Initialize audio
	GameAudioLoad();
	
	// Initialize fonts
	GameFontsSetup();

	// Initialize shaders
	GameShadersSetup();

	// Initialize application window
	GameWindowSetup();