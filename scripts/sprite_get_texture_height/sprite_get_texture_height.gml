/// @self
/// @description						Returns the height of a sprite on its texture page in pixels.
/// @param {Asset.GMSprite} _sprite_id	The sprite asset to get the texture height of.
/// @returns {Real}
function sprite_get_texture_height(_sprite_id)
{
    var _uvs = sprite_get_uvs(_sprite_id, 0);
    var _tex_page = sprite_get_texture(_sprite_id, 0);
	
    return round((_uvs[3] - _uvs[1]) / texture_get_texel_height(_tex_page));
}