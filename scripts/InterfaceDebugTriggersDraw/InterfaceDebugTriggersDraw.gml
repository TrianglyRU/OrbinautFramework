function InterfaceDebugTriggersDraw()
{
	// Exit the code if disabled
	if !DebugTriggers
	{
		exit;
	}
	draw_set_alpha(0.5);
	
	// Draw triggers
	with all
	{
		draw_rectangle_colour(x + Obj_TriggerLeft, y + Obj_TriggerTop, x + Obj_TriggerRight - 1, y + Obj_TriggerBottom - 1, $ffff00, $ffff00, $ffff00, $ffff00, false);
	}
	draw_set_alpha(1.0);	
}