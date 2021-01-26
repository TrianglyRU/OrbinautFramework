/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	background_use_parallax();
	
	// Perform parallax
	background_set_parallax(0, 0, 0.1, 0.95, 0, 130, 46, 0, 0);
	background_set_parallax(0, 0, 0.5, 0.95, 0, 224, 77, 0, 0);
	
	// Apply parallax
	background_apply_parallax();
