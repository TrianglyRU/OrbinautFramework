function InterfaceDebugTriggersDraw()
{
	// Exit if not allowed to display
	if !Game.DevMode or !Stage.DoUpdate or !DebugToggle
	{
		exit;
	}
	
	// Toggle triggers debug
	if keyboard_check_pressed(ord("R"))
	{
		DebugTriggers = !DebugTriggers;
	}
	
	// Display triggers
	if DebugTriggers
	{
		draw_set_alpha(0.5);
		with all
		{
			if variable_instance_exists(id, "Obj_TriggerStatus")
			{
				draw_rectangle_colour(x + Obj_TriggerLeft, y + Obj_TriggerTop, x + Obj_TriggerRight - 1, y + Obj_TriggerBottom - 1, $ffff00, $ffff00, $ffff00, $ffff00, false);
			}
		}
		draw_set_alpha(1.0);
	}	
}