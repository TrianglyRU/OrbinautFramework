/// @function palette_load(paletteType, paletteList)
function palette_load(paletteType, paletteList)
{
	if !paletteList
	{
		Palette.PaletteSet[paletteType] = false;
		exit;
	}
	
	// Do texture and texel initialization
	var tex		= sprite_get_texture(paletteList, 0);
	var UVs		= sprite_get_uvs(paletteList, 0);
	var texel_x	= texture_get_texel_width(tex);
	var texel_y = texture_get_texel_height(tex);
	
	// Load the data into palette slot
	Palette.PaletteSet[paletteType] = [tex, texel_x, texel_y, UVs[0] + texel_x / 2, UVs[1] + texel_y / 2, UVs[3]];
}