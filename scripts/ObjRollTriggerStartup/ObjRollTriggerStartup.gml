function ObjRollTriggerStartup()
{
	State   = 0;
	visible = false;
	
	// Set object properties
	if object_index == RollTriggerV
	{
		object_set_triggerbox(-8, 8, -32, 32);
	}
	else if object_index == RollTriggerH
	{
		object_set_triggerbox(-32, 32, -8, 8);
	}
	object_set_unload(FlagPause);
}