function GameFontsSetup()
{	
	//  Initialize fonts
	Game.Font[FontDebug]   = font_add_sprite_ext(fontTexture_Debug, "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890*.:-+abcdefghijklmnopqrstuvwxyz", false, 0);
	Game.Font[FontDigits1] = font_add_sprite_ext(fontTexture_Counter, "0123456789:';", false, 1);
	Game.Font[FontDigits2] = font_add_sprite_ext(fontTexture_SmallCounter, "0123456789",  false, 1);
	Game.Font[FontCard]    = font_add_sprite_ext(fontTexture_TitleCard2, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", false, -2);
	Game.Font[FontMenu]    = font_add_sprite_ext(fontTexture_Menu, "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:", false, 1);
}