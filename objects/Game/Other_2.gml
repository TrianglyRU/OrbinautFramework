/// @description Startup Initialization
// You can call your scripts in this editor. One-time initial
	
	// Initialize the framework
	GameMacroInitialization();
	GameInitialization();
	
	// Initialize fonts
	GameFontsInitialization();
	
	// Initialize application window
	GameApplicationWindowCreate();
	
	// Initialize shaders
	GameShadersInitialization();
	
	// Load tiledata
	GameTiledataLoad();