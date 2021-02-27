/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	background_use_parallax();
	
	// Perform parallax
	background_set_parallax(0, 200, 0.05, 0.9, 0, 0, 67, 0, 0);
	background_set_parallax(0, 200, 0.08, 0.9, 0, 67, 76, 0, 0);
	background_set_parallax(0, 200, 0.08, 0.9, 0, 143, sprite_height, 0, 0);
	
	// Apply parallax
	background_apply_parallax();