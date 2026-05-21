if player_index != 0
{
	return;
}

var _object_array = debug_mode_array;

with obj_gameobject
{
	switch object_index
	{
		// Player
		case obj_player_spawn:
		case obj_player:
		case obj_tail:
		case obj_shield:
		
		// GUI
		case obj_gui_hud:
		case obj_gui_titlecard:
		case obj_gui_save:
		
		// Stage
		case obj_water:
		
		// Badniks
		case obj_sol_fireball:
		
		// Other
		case obj_star_post_lamp:		
		case obj_capsule_button:
		case obj_capsule_gate:
		case obj_capsule_lock:
		
			// Skip
			continue;
	}
	
	if !array_contains(_object_array, object_index)
	{
		array_push(_object_array, object_index);
	}
}