function BackgroundSetup()
{
	// Render background behind everything
	depth = 9999;
	
	// Setup parallax
	switch room
	{
		// Setup example
		/* DummyValues[bg_sprite] = [PosX, PosY, ScrollX, ScrollY, OffsetX, OffsetY, RenderTop, RenderBottom, XScaleHeight, XScaleForce, YScale]; */
		
		case MQZ1:
		case MQZ2:
		{
			/*// Background sprites
			BackgroundSprites = [tex_mqz_bg00, tex_mqz_bg00, tex_mqz_bg01, tex_mqz_bg02, tex_mqz_bg02, tex_mqz_bg02];
			
			// tex_mqz_bg00
			BackgroundValues[0] = [0, 0, 0,    0,    0, 0, 0,   167, 0, 0,   false];
			BackgroundValues[1] = [0, 0, 0.15, 0.01, 0, 0, 176, 301, 2, 0.3, true];
			
			// tex_mqz_bg01
			BackgroundValues[2] = [0, 0, 0.1,  0.01, 0, 0, 0,   301, 0, 0, false];
			
			// tex_mqz_bg02
			BackgroundValues[3] = [0, 0, 0.01, 0.01, 0, 0, 0,   71,	 0, 0, false];
			BackgroundValues[4] = [0, 0, 0.2,  0.01, 0, 0, 72,  175, 0, 0, false];
			BackgroundValues[5] = [0, 0, 0.5,  0.01, 0, 0, 176, 301, 0, 0, false];*/
			
			// Background sprites
			BackgroundSprites = [tex_mqz_newbg00, tex_mqz_newbg00, tex_mqz_newbg00, tex_mqz_newbg00, tex_mqz_newbg01, tex_mqz_newbg01, tex_mqz_newbg02, tex_mqz_newbg02, tex_mqz_newbg02, tex_mqz_newbg03];
			
			// tex_mqz_bg00
			BackgroundValues[0] = [0, 0, 0,    0,    0, 0, 0,   167, 0, 0, false];
			BackgroundValues[1] = [0, 0, 0.0,  0.03, 0, 0, 176, 226, 0, 0, false];
			BackgroundValues[2] = [0, 0, 0.05, 0.03, 0, 0, 227, 247, 0, 0, false];
			BackgroundValues[3] = [0, 0, 0.08, 0.03, 0, 0, 248, 287, 0, 0, false];
			
			// tex_mqz_bg01
			BackgroundValues[4] = [0, 0, 0.12, 0.03, 0, 0, 0,   175, 0, 0, false];
			BackgroundValues[5] = [0, 0, 0.16, 0.03, 0, 0, 205, 287, 0, 0, false];
			
			// tex_mqz_bg02
			BackgroundValues[6] = [0, 0, 0.01, 0.03, 0, 0, 0,   71,	0, 0, false];
			BackgroundValues[7] = [0, 0, 0.2,  0.03, 0, 0, 130, 175, 0, 0, false];
			BackgroundValues[8] = [0, 0, 0.24, 0.03, 0, 0, 271, 382, 0, 0, false];
			
			// tex_mqz_bg03
			BackgroundValues[9] = [0, 0, 0.2, 0.03, 0, 0, 176, 301, 1, 0.55, true];
		}
		break;
		default: 
		{
			// Background sprites
			BackgroundSprites = [];
		}
		break;
	}
	
	// Automaticly setup width and texel for the background
	var BackgroundParts = array_length(BackgroundSprites);
	for (var i = 0; i < BackgroundParts; i++)
	{
		BackgroundValues[i][11] = sprite_get_width(BackgroundSprites[i]);
		BackgroundValues[i][12] = texture_get_texel_width(sprite_get_texture(BackgroundSprites[i], 0));
	}
}