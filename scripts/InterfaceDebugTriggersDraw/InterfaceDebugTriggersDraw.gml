function InterfaceDebugTriggersDraw()
{
	// Exit if disabled
	if !DebugTriggers
	{
		exit;
	}
	
	// Set alpha
	draw_set_alpha(0.5);
	
	// Draw triggers
	with all
	{
		if variable_instance_exists(id, "Obj_TriggerLeft")
		{
			draw_rectangle_colour(x + Obj_TriggerLeft, y + Obj_TriggerTop, x + Obj_TriggerRight - 1, y + Obj_TriggerBottom - 1, $ffff00, $ffff00, $ffff00, $ffff00, false);
		}
	}
	
	// Restore alpha
	draw_set_alpha(1.0);	
}