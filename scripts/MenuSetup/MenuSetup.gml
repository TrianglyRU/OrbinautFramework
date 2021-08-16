function MenuSetup()
{
	for (var i = 0; i < 20; i++)
	{
		MenuSize[i]   = 0;
		MenuHeader[i] = "TEMPLATE HEADER";
		
		PreviousMenuID[i]   = 0;
	}
	
	for (var i = 0; i < 4; i++)
	{
		DisplayData[i] = 0;
	}
	
	MenuID           = 0;
	OptionID		 = 0;
}