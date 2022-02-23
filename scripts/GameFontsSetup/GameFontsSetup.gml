function GameFontsSetup()
{	
	// Add fonts
	Font.FontDefault = font_add_sprite_ext(font_default, "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890*.:!-+abcdefghijklmnopqrstuvwxyz", false, 0);
	Font.FontMenu    = font_add_sprite_ext(font_menu,	 "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:-></", false, 1);
	Font.FontCard    = font_add_sprite_ext(font_card,    "ABCDEFGHIJKLMNOPQRSTUVWXYZ", true, 1);
	Font.FontDigits1 = font_add_sprite_ext(font_counter, "0123456789:';", false, 1);
	Font.FontDigits2 = font_add_sprite_ext(font_counter_small, "0123456789", false, 1);
}