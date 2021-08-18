function MenuOptionsDisplay()
{
	// Set font
	draw_set_font(Game.Font[FontMenu]);
	
	// Set font align
	draw_set_halign(fa_center);
	
	// Display header
	string_display(200, 50, MenuHeader[MenuID], 1);
	
	// Display options
	for (var i = 0; i < MenuSize[MenuID]; i++)
	{
		string_display(Game.Width / 2, 100 + i * 16, MenuOption[MenuID][i], 1);
	}
	
	// Display pointer
	var OptionLength = string_length(MenuOption[MenuID][OptionID]) * 8;
	
	string_display(Game.Width / 2 - OptionLength / 2 - 16, 100 + OptionID * 16, ">", 1);
	string_display(Game.Width / 2 + OptionLength / 2 + 16, 100 + OptionID * 16, "<", 1);
}