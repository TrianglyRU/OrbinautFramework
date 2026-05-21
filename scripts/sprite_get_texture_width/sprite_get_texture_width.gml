/// @self
/// @description						Returns the width of a sprite on its texture page in pixels.
/// @param {Asset.GMSprite} _sprite_id	The sprite asset to get the texture width of.
/// @returns {Real}
function sprite_get_texture_width(_sprite_id)
{
    var _uvs = sprite_get_uvs(_sprite_id, 0);
    var _tex_page = sprite_get_texture(_sprite_id, 0);
	
    return round((_uvs[2] - _uvs[0]) / texture_get_texel_width(_tex_page));
}