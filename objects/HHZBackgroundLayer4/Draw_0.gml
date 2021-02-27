/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	background_use_parallax();
	
	// Set autoscroll speed
	Scroll1 -= 0.07;
	Scroll2 -= 0.01;
	Scroll3 -= 0.02;
	
	// Perform parallax
	background_set_parallax(0, -75, 0.009, 0.92, Scroll1, 0, 151, 0, 0);
	background_set_parallax(0, -75, 0.009, 0.92, Scroll2, 151, 17, 0, 0);
	background_set_parallax(0, -75, 0, 0.92, 0, 168, 11, 0, 0);
	background_set_parallax(0, -75, 0.009, 0.92, Scroll3, 179, 67, 0, 0);
	background_set_parallax(0, -75, 0.009, 0.92, 0, 246, sprite_height, 1, 0.6);
	
	// Apply parallax
	background_apply_parallax();
