/// @description Startup
// You can write your code in this editor

	// Inherit the parent event
	event_inherited();
	
	// Setup this object
	var Heightmap = 
	[
		81,81,81,81,
		82,82,82,82,82,82,
		83,83,83,83,83,83,
		84,84,84,84,84,84,84,
		85,85,85,85,85,85,
		86,86,86,86,86,86,
		87,87,87,87,87,87,87,
		88,88,88,88,
		89,89,89,89,89,89,89,89,
		90,90,90,90,90,90,90,
		91,91,91,91,91,91,
		92,92,92,92,92,92,
		93,93,93,93,93,93,93,
		94,94,94,94,94,94,
		95,95,95,95,95,95,
		96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96
	];
	object_set_solidbox(array_length(Heightmap) div 2, sprite_get_height(sprite_index) div 2, Heightmap);