/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	background_use_parallax();
	
	// Set offsets for act 2
	var offsetX = 0;
	if Stage.ActID == 1
	{
		var offsetX = -203;
	}
	
	// Perform parallax
	background_set_parallax(0, 0, 0.022, 1, offsetX, 0, 80, sprite_height, 0, 0);
	
	// Apply parallax
	background_apply_parallax();