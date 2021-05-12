/// @description Insert description here
// You can write your code in this editor
	
	bg_object_initialize();
	bg_object_parallax(x, y, 0.02, 1, 0, 0, 0, 48, 0, 0);
	bg_object_parallax(x, y, 0.04, 1, 0, 0, 48, 48, 0, 0);
	bg_object_parallax(x, y, 0.06, 1, 0, 0, 96, sprite_height, 0, 0);
	bg_object_update();