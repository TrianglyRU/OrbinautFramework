/// @self
/// @description Loads palette information from two sprite textures.
/// @param {Asset.GMSprite} primary The sprite data for the primary palette.
/// @param {Asset.GMSprite} secondary The sprite data for the secondary palette.
function pal_load(_primary, _secondary)
{
	var _palette = c_framework.palette;
	var _tex, _uvs, _texel_x, _texel_y;

	// Set the primary palette data
	if sprite_exists(_primary)
	{
		_tex = sprite_get_texture(_primary, 0);
		_uvs = sprite_get_uvs(_primary, 0);
		_texel_x = texture_get_texel_width(_tex);
		_texel_y = texture_get_texel_height(_tex);

		_palette.colour_data[0] = [_tex, _texel_x, _texel_y, _uvs[0] + _texel_x / 2, _uvs[1] + _texel_y / 2, _uvs[3]];
	}

	// Set the secondary palette data
	if sprite_exists(_secondary)
	{
		_tex = sprite_get_texture(_secondary, 0);
		_uvs = sprite_get_uvs(_secondary, 0);
		_texel_x = texture_get_texel_width(_tex);
		_texel_y = texture_get_texel_height(_tex);

		_palette.colour_data[1] = [_tex, _texel_x, _texel_y, _uvs[0] + _texel_x / 2, _uvs[1] + _texel_y / 2, _uvs[3]];
	}
}