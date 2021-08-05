function ScreenDebugTriggersDisplay()
{
	// Check if general debugging is enabled
	if DebugToggle
	{
		// Draw position points
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