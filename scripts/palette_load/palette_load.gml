/// @function palette_load(type,list)
function palette_load(type, list)
{
	if !list
	{
		Palette.PaletteSet[type] = false;
		exit;
	}
	
	// Do texture and texel initialization
	var tex		= sprite_get_texture(list, 0);
	var UVs		= sprite_get_uvs(list, 0);
	var texel_x	= texture_get_texel_width(tex);
	var texel_y = texture_get_texel_height(tex);
	
	// Load the data into palette slot
	Palette.PaletteSet[type] = [tex, texel_x, texel_y, UVs[0] + texel_x / 2, UVs[1] + texel_y / 2, UVs[3]];
}