/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	bg_object_initialize();
	
	var offsetX = 0;
	if Stage.ActID == 1
	{
		var offsetX = 205;
	}
	
	// Perform parallax
	bg_object_parallax(0, 128, 0.2,  1, offsetX, 0, 0,   80,		     0, 0);
	bg_object_parallax(0, 128, 0.22, 1, 0,		  0, 80,  38,			 0, 0);
	bg_object_parallax(0, 128, 0.18, 1, 0,		  0, 108, sprite_height, 0, 0);
	
	// Apply parallax
	bg_object_update();
