function ObjBumperStartup()
{
	// Create variables
	Ready      = 0;
	ScoreLimit = 0;
	
	// Set flags
	Ready	   = true;
	ScoreLimit = 10;
	
	// Set object hitbox
	object_set_hitbox(8, 8);
	
	// Set object depth
	object_set_depth(Player, true);
	
	// Set object unload type
	object_set_unload(TypePause);
}