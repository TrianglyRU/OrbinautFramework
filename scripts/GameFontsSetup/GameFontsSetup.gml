function GameFontsSetup()
{	
	Game.Font[Debug]        = font_add_sprite_ext(spr_font_debug,		  "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890*.:!-+abcdefghijklmnopqrstuvwxyz", false, 0);
	Game.Font[Counter]      = font_add_sprite_ext(spr_font_counter,		  "0123456789:';",										                  false, 1);
	Game.Font[CounterSmall] = font_add_sprite_ext(spr_font_counter_small, "0123456789",														      false, 1);
	Game.Font[Card]		    = font_add_sprite_ext(spr_font_card,		  "ABCDEFGHIJKLMNOPQRSTUVWXYZ",										      false, 0);
	Game.Font[Menu]         = font_add_sprite_ext(spr_font_menu,		  "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:-></",						      false, 1);
}