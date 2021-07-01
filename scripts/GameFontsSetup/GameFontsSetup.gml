function GameFontsSetup()
{	
	//  Initialize fonts
	Game.Font[FontDebug]   = font_add_sprite_ext(spr_font_debug,		 "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890*.:-+abcdefghijklmnopqrstuvwxyz", false, 0);
	Game.Font[FontDigits1] = font_add_sprite_ext(spr_font_counter,		 "0123456789:';",										                false, 1);
	Game.Font[FontDigits2] = font_add_sprite_ext(spr_font_counter_small, "0123456789",														    false, 1);
	Game.Font[FontCard]    = font_add_sprite_ext(spr_font_card,		     "ABCDEFGHIJKLMNOPQRSTUVWXYZ",										    false, 0);
	Game.Font[FontMenu]    = font_add_sprite_ext(spr_font_menu,		     "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:-><",								false, 1);
}