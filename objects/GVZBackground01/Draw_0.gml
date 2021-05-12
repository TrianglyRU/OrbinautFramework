/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	bg_object_initialize();
	
	// Set offsets for act 2
	var offsetX = 0;
	if Stage.ActID == 1
	{
		var offsetX = -203;
	}
	
	// Perform parallax
	bg_object_parallax(0, 0, 0.022, 1, offsetX, 0, 80, sprite_height, 0, 0);
	
	// Apply parallax
	bg_object_update();