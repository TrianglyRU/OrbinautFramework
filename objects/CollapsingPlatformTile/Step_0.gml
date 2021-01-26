/// @description Falling & Destruction
// You can write your code in this editor
	
	// Destroy if under the screen
	if (y >= Screen.ViewY + Screen.Height + 32) instance_destroy();
