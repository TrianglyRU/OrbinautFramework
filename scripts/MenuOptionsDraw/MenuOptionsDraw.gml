function MenuOptionsDraw()
{
	// Display header
	draw_text(200, 50, MenuHeader[MenuID]);
	
	// Display options
	var Page = OptionID div 7;
	var Limit = min(MenuSize[MenuID], Page * 7 + 7);
	for (var i = Page * 7; i < Limit; i++)
	{
		draw_text(Game.Width / 2, 100 + i mod 7 * 16, MenuOption[MenuID][i]);
	}
	
	// Display pages
	var AllPages = MenuSize[MenuID] div 7;
	if AllPages
	{
		draw_text(Game.Width / 2, 212, "-" + string(Page + 1) + "/" + string(AllPages + 1) + "-");
	}
	
	
	// Display pointer
	var OptionLength = string_length(MenuOption[MenuID][OptionID]) * 8;
	
	draw_text(Game.Width / 2 - OptionLength / 2 - 16, 100 + OptionID mod 7 * 16, ">");
	draw_text(Game.Width / 2 + OptionLength / 2 + 16, 100 + OptionID mod 7 * 16, "<");
}