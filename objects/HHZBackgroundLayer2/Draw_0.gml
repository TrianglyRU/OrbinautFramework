/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	background_use_parallax();
	
	// Perform parallax
	background_set_parallax(0, 65, 0.22, 0.95, 0, 0, 159, 0, 0);
	background_set_parallax(0, 65, 0.2, 0.95, 0, 159, 189, 0, 0);
	
	// Apply parallax
	background_apply_parallax();