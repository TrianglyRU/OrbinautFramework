/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	background_use_parallax();
	
	// Perform parallax
	background_set_parallax(0, 65, 0.13, 0.95, 0, 0, 175, 0, 0);
	background_set_parallax(0, 65, 0.15, 0.95, 0, 175, 102, 0, 0);
	background_set_parallax(0, 65, 0.2, 0.95, 0, 277, 71, 3, 0.5);
	
	// Apply parallax
	background_apply_parallax();