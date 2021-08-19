function MenuOptionsDraw()
{
	// Display header
	draw_text(200, 50, MenuHeader[MenuID]);
	
	// Display options
	for (var i = 0; i < MenuSize[MenuID]; i++)
	{
		draw_text(Game.Width / 2, 100 + i * 16, MenuOption[MenuID][i]);
	}
	
	// Display pointer
	var OptionLength = string_length(MenuOption[MenuID][OptionID]) * 8;
	
	draw_text(Game.Width / 2 - OptionLength / 2 - 16, 100 + OptionID * 16, ">");
	draw_text(Game.Width / 2 + OptionLength / 2 + 16, 100 + OptionID * 16, "<");
}