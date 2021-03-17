function GameShaderPaletteSetLoad()
{	
	switch room 
	{	
		// Load palette set for Moonlight Base
		case MBZ:
		case MBZ2:
		{
			Game.PaletteSet = pal_MoonlightBaseZone; 
		}
		break;
		case DevMenu:
		case HHZ:
		{
			Game.PaletteSet = false;
		}
		default:
		{
			Game.PaletteSet = false; 
		}
		break;
	}
	
	var tex = sprite_get_texture(Game.PaletteSet, 0);
	var UVs = sprite_get_uvs(Game.PaletteSet, 0);
	var texel_x  = texture_get_texel_width(tex);
	var texel_y  = texture_get_texel_height(tex);
	
	Game.PaletteSet = [Game.PaletteSet, tex, texel_x, texel_y, UVs[0] + texel_x / 2, UVs[1] + texel_y / 2, UVs[2], UVs[3]];
}