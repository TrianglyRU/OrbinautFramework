/// @description Perform Parallax
// You can write your code in this editor
	
	// Initialize shader for this object
	background_use_parallax();
	
	if Stage.State == ActStateLoading
	{
		scroll = 0;
	}
	//variable_set_temp("scroll");
	if Stage.State != ActStateLoading and Stage.State != ActStateRestart and Stage.State != ActStateUnload
	{
		scroll -= 0.02;
	}
	
	// Set offsets for act 2
	var offsetX1 = 0;
	var offsetX2 = 0;
	if Stage.ActID == 1
	{
		offsetX1 = -92;
		offsetX2 = -27;
	}

	// Perform parallax
	background_set_parallax(0, 0, 0.01,   1, offsetX1, 0, 0,   117,			  0, 0);
	background_set_parallax(0, 0, 0.015,  1, offsetX2, 0, 117, 11,		      0, 0);
	background_set_parallax(0, 0, 0.022,  1, scroll,   0, 128, sprite_height, 1, 1);
	
	// Apply parallax
	background_apply_parallax();