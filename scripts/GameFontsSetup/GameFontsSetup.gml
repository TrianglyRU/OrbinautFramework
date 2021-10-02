function GameFontsSetup()
{	
	// Add fonts
	game_font_add(font_default,       "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890*.:!-+abcdefghijklmnopqrstuvwxyz", 0);
	game_font_add(font_menu,		  "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:-></", 1);
	game_font_add(font_card,		  "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 0);
	game_font_add(font_counter,       "0123456789:';", 1);
	game_font_add(font_counter_small, "0123456789",    1);
}