/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	background_use_parallax();
	
	// Perform parallax
	background_set_parallax(0, 190, 0.18, 0.87, 0, 0, 80, 0, 0);
	background_set_parallax(0, 190, 0.22, 0.87, 0, 80, 24, 0, 0);
	background_set_parallax(0, 190, 0.26, 0.87, 0, 104, sprite_height, 0, 0);
	
	// Apply parallax
	background_apply_parallax();
