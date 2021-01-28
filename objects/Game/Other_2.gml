/// @description Startup Initialization
// You can call your scripts in this editor. One-time initial
	
	// Initialize the framework
	GameMacroInitialization();
	GameInitialization();
	
	// Initialize audio
	GameAudioGroupsLoad();
	
	// Initialize fonts
	GameFontsInitialization();

	// Initialize shaders
	GameShadersInitialization();
	
	// Load tiledata
	GameTiledataLoad();
	
	// Initialize application window
	GameApplicationWindowCreate();