/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	background_use_parallax();
	
	// Perform parallax
	background_set_parallax(0, 65, 0.30, 0.95, 0, 0, 119, 0, 0);
	background_set_parallax(0, 65, 0.36, 0.95, 0, 119, 31, 0, 0);
	background_set_parallax(0, 65, 0.23, 0.95, 0, 150, 198, 0, 0);
	
	// Apply parallax
	background_apply_parallax();