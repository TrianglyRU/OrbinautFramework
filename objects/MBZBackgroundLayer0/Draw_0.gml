/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	background_use_parallax();
	
	// Perform parallax
	background_set_parallax(0, 0, 0.01, 0.95, 0, 0, 72, 0, 0);
	background_set_parallax(0, 0, 0.05, 0.95, 0, 72, 104, 0, 0);
	background_set_parallax(0, 0, 0.1, 0.95, 0, 176, 125, 5, 0.5);
	
	// Apply parallax
	background_apply_parallax();