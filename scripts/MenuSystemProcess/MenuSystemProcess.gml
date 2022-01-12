function MenuSystemProcess()
{	
	// Navigate between options
	if Input.DownPress
	{
		OptionID++;
	}
	else if Input.UpPress
	{
		OptionID--; 
	}
	OptionID = loop_value(OptionID, 0, MenuSize[MenuID]);

	// Back to previous menu
	if Input.BPress and MenuID != 0
	{
		if PreviousOptionID[MenuID] != noone
		{
			OptionID = PreviousOptionID[MenuID];
		}
		else
		{
			OptionID = 0;
		}
		MenuID = PreviousMenuID[MenuID];
	}
}