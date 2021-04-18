/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	background_use_parallax();
	
	// Perform parallax
	background_set_parallax(0, -80, 0.02, 0.87, 0, 0, 256, 0, 0);
	background_set_parallax(0, -80, 0.02, 0.87, 0, 256, sprite_height, 2, 0.95);
	
	// Apply parallax
	background_apply_parallax();