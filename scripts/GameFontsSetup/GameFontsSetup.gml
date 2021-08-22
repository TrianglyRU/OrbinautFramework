function GameFontsSetup()
{	
	Game.Font[font_default]       = font_add_sprite_ext(font_default,	    "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890*.:!-+abcdefghijklmnopqrstuvwxyz", false, 0);
	Game.Font[font_counter]       = font_add_sprite_ext(font_counter,	    "0123456789:';",										                false, 1);
	Game.Font[font_counter_small] = font_add_sprite_ext(font_counter_small, "0123456789",														    false, 1);
	Game.Font[font_card]		  = font_add_sprite_ext(font_card,		    "ABCDEFGHIJKLMNOPQRSTUVWXYZ",										    false, 0);
	Game.Font[font_menu]          = font_add_sprite_ext(font_menu,		    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:-></",						    false, 1);
}