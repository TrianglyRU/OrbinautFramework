function MenuAutomaticProcess()
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
	
	// Select
	if Input.APress or Input.StartPress
	{
		var Target  = MenuRedirect[MenuID][OptionID];
		if  Target != noone
		{
			PreviousOptionID[Target] = OptionID;
			PreviousMenuID[Target]   = MenuID;
			MenuID					 = Target;
			OptionID				 = 0;
		}
	}

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