/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	background_use_parallax();
	
	// Perform parallax
	background_set_parallax(0, 65, 0.05, 0.95, 0, 0, 73, 0, 0);
	background_set_parallax(0, 65, 0.08, 0.95, 0, 73, 70, 0, 0);
	background_set_parallax(0, 65, 0.1, 0.95, 0, 167, 128, 0, 0);
	
	// Apply parallax
	background_apply_parallax();