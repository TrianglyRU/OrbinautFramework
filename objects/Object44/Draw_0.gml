/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	background_use_parallax();
	
	// Perform parallax
	background_set_parallax(0, -80, 0.07, 0.87, 0, 0, sprite_height, 0, 0);
	
	// Apply parallax
	background_apply_parallax();