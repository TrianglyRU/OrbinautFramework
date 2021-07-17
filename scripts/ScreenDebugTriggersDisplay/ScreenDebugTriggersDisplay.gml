function ScreenDebugTriggersDisplay()
{
	// Check if general debugging is enabled
	if DebugToggle
	{
		// Draw position points
		draw_set_alpha(0.5);
		with all
		{
			if variable_instance_exists(id, "objXRadiusTriggerLeft")
			{
				draw_rectangle_colour(x + objXRadiusTriggerLeft, y + objYRadiusTriggerTop, x + objXRadiusTriggerRight - 1, y + objYRadiusTriggerBottom - 1, $ffff00, $ffff00, $ffff00, $ffff00, false);
			}
		}
		draw_set_alpha(1.0);
	}	
}