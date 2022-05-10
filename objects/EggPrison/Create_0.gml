/// @description Startup
// You can write your code in this editor
	
	ExplosionTimer = irandom(32);
	TargetAnimal   = noone;
	State	       = 0;
	StateTimer	   = 0;
	
	// Set object properties
	object_set_unload(FlagPause);
	object_set_depth(Player, 0);
	object_set_solidbox(32, 25, false);
	
	// Create button object
	ButtonObj = instance_create(x, y - 38, PrisonButton);