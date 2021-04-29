/// @description Insert description here
// You can write your code in this editor
	
	if keyboard_check_pressed(ord("N"))
	{
		Mode += 1;
		Mode = loop_value_range(Mode, 0, 8);
	}
	switch Mode
	{
		// Collide all
		case 0: 
		object_act_solid(true, true,  true, false);
		break;
		
		// Collide sides and bottom
		case 1: 
		object_act_solid(true, false, true, false);
		break;
		
		// Collide sides and top
		case 2: 
		object_act_solid(true, true,  false, false);
		break;
		
		// Collide top and bottom
		case 3: 
		object_act_solid(false, true, true, false);
		break;
		
		// Collide only top
		case 4: 
		object_act_solid(false, true, false, false);
		show_debug_message("Top");
		break;
		
		// Collide only bottom
		case 5: 
		object_act_solid(false, false, true, false);
		break;
		
		// Collide only sides
		case 6: 
		object_act_solid(true, false, false, false);
		break;
		
		// No collision
		case 7: 
		object_act_solid(false, false, false, false);
		break;
		
	}