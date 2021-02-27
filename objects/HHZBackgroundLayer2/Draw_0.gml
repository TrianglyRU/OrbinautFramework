/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	background_use_parallax();
	
	// Perform parallax
	background_set_parallax(0, 200, 0.14, 0.9, 0, 0, 84, 0, 0);
	background_set_parallax(0, 200, 0.17, 0.9, 0, 84, 51, 0, 0);
	background_set_parallax(0, 200, 0.175, 0.9, 0, 135, sprite_height, 0, 0);
	
	// Apply parallax
	background_apply_parallax();