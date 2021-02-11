function GameFontsSetup()
{	
	// Debug view font
	Game.Font[0] = font_add_sprite_ext(fontTexture_Debug, "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890*.:-+", false, 0);
	
	// HUD counters font
	Game.Font[1] = font_add_sprite_ext(fontTexture_Counter,		 "0123456789:", false, 1);
	Game.Font[2] = font_add_sprite_ext(fontTexture_SmallCounter, "0123456789",  false, 1);
	
	// Title card font
	Game.Font[3] = font_add_sprite_ext(fontTexture_TitleCard, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", false, 2);
	
	// Menu text font
	Game.Font[4] = font_add_sprite_ext(fontTexture_Menu, "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:", false, 1);
}