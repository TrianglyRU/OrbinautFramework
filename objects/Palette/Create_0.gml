/// @description Insert description here
// You can write your code in this editor
	
	// Initialize variables
	PaletteVariables();
	
	RendererSetup();
	
	// Load a palette set to use in the room
	PaletteDataLoad();

	// Reset fade state
	PaletteFadeReset();
	
	// Handle static palette
	PaletteHandleStatic();