/// @description Game Startup
// You can call your scripts in this editor
	
	// Initialize macros and global variables
	GameMacro();
	GameVariables();
	
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
	GameLoadSettings();