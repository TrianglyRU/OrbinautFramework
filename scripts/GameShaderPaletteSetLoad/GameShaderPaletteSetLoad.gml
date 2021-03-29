function GameShaderPaletteSetLoad()
{	
	// Set palette sprite to load
	switch room 
	{	
		// Load palette set for Moonlight Base
		case MBZ:
		case MBZ2:
			Game.PaletteSet = pal_MoonlightBaseZone; 
		break;
		
		// Load palette set for Hilltop Heights
		case HHZ:
			Game.PaletteSet = false;
		break;
		
		// Disable palettes for other rooms
		default:
			Game.PaletteSet = false; 
		break;
	}
	
	// Do shader initialization math
	var tex			= sprite_get_texture(Game.PaletteSet, 0);
	var UVs			= sprite_get_uvs(Game.PaletteSet, 0);
	var texel_x		= texture_get_texel_width(tex);
	var texel_y		= texture_get_texel_height(tex);
	Game.PaletteSet = [Game.PaletteSet, tex, texel_x, texel_y, UVs[0] + texel_x / 2, UVs[1] + texel_y / 2, UVs[2], UVs[3]];
}