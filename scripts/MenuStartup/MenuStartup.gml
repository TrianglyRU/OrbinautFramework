function MenuStartup()
{
	// Set default data for 20 MenuIDs
	for (var i = 0; i < 20; i++)
	{
		MenuHeader[i]	  = "TEMPLATE HEADER";
		MenuSize[i]	      = 0;
		PreviousMenuID[i] = 0;
	}
	
	// Initialise variables
	for (var i = 0; i < 4; i++)
	{
		DisplayData[i] = 0;
	}
	MenuID   = 0;
	OptionID = 0;
	
	// Set font and its align
	draw_set_font(Font.FontMenu);
	draw_set_halign(fa_center);
}