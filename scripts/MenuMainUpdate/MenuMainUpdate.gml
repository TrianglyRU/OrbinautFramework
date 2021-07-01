function MenuMainUpdate()
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
	
	// React to key A or key Start
	if (Input.APress or Input.StartPress) and MenuAction[MenuID][OptionID] != noone
	{
		// Get target menu
		var ThisMenu = MenuID;
		var NewMenu  = MenuAction[MenuID][OptionID];
		
		// Save current menu
		if NewMenu > ThisMenu
		{
			PreviousMenuID[NewMenu] = ThisMenu;
		}
		
		// Load new menu
		MenuID   = NewMenu;
		OptionID = 0;
	}
	
	// React to key B
	else if Input.BPress and MenuID != 0
	{
		MenuID   = PreviousMenuID[MenuID];
		OptionID = 0;
	}
}