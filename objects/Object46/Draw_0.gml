/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	background_use_parallax();
	
	variable_set_temp("scroll");
	scroll -= 0.02;
	
	// Perform parallax
	background_set_parallax(0, 0, 0.01, 1, 0, 0, 117, 0, 0);
	background_set_parallax(0, 0, 0.015, 1, 0, 117, 11, 0, 0);
	background_set_parallax(0, 0, 0.022, 1, scroll, 128, sprite_height, 1, 1);
	
	// Apply parallax
	background_apply_parallax();