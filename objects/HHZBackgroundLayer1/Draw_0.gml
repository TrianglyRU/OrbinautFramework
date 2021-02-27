/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	background_use_parallax();
	
	// Perform parallax
	background_set_parallax(0, 200, 0.11, 0.9, 0, 0, 151, 0, 0);
	background_set_parallax(0, 200, 0.13, 0.9, 0, 151, 112, 0, 0);
	background_set_parallax(0, 200, 0.13, 0.9, 0, 263, sprite_height, 3, 0.5);
	
	// Apply parallax
	background_apply_parallax();