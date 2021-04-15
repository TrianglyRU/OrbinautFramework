/// @function palette_data(palette)
function palette_data(Palette)
{
	// Do shader initialization math
	var tex		= sprite_get_texture(Palette, 0);
	var UVs		= sprite_get_uvs(Palette, 0);
	var texel_x	= texture_get_texel_width(tex);
	var texel_y = texture_get_texel_height(tex);
	return [tex, texel_x, texel_y, UVs[0] + texel_x / 2, UVs[1] + texel_y / 2, UVs[3]];
}