/// @description Startup
// You can write your code in this editor
	
	PosX		   = x;
	PosY		   = y;
	Direction	   = image_xscale;
	Ysp			   = 0;
	State		   = 0;
	StateTimer	   = 0;
	PreviousSprite = 0;

	// Set object properties
	object_set_unload(FlagReset);
	object_set_depth(Player, 0);
	object_set_hitbox(16, 16);