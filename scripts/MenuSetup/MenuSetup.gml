function MenuSetup()
{
	for (var i = 0; i < 20; i++)
	{
		MenuSize[i]   = 0;
		MenuHeader[i] = "TEMPLATE HEADER";
	}
	
	MenuID           = 0;
	OptionID		 = 0;
	PreviousMenuID   = 0;
	PreviousOptionID = 0;
	DisplayData		 = 0;
	DataMode		 = 0;	// 0 - don't save, 1 - do save, 2 - delete
}