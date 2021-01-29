/// @description Room-based Initialization
// You can call your scripts in this editor
	
	// Automaticly configure the room
	GameRoomSetup();
	
	// Reset fade shader
	GameShaderFadeReset();
	
	// Load a palette set to use in the room
	GameShaderPaletteSetLoad();
	
	// Reset audio volume
	GameAudioGroupsVolumeReset();