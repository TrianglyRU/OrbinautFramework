/// @description Palette & Fade
// You can write your code in this editor

	if (Stage.GamePaused) exit;
	
	// Update dynamic shift
	ScreenPaletteHandleDynamic();
	
	// Update fade shader
	ScreenPaletteFadeUpdate();