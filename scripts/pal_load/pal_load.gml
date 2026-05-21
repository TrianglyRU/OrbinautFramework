/// @self
/// @description									Loads the primary (A) and the secondary (B) palette data from two sprite textures.
/// @param {Asset.GMSprite|Undefined} _primary		The primary palette sprite.
/// @param {Asset.GMSprite|Undefined} _secondary	The secondary palette sprite.
function pal_load(_primary, _secondary)
{
	var _sprites = [_primary, _secondary];
	
	for (var _i = 0; _i < 2; _i++)
	{
		var _sprite = _sprites[_i];
		
		if _sprite != undefined
		{
			var _texture = sprite_get_texture(_sprite, 0);
			var _uvs = sprite_get_uvs(_sprite, 0);
			var _texel_w = texture_get_texel_width(_texture);
			var _texel_h = texture_get_texel_height(_texture);
			
			obj_game.palette_data[_i] = [_texture, _texel_w, _texel_h, _uvs[0], _uvs[1], _uvs[3]];
		}
		else
		{
			obj_game.palette_data[_i] = undefined;
		}
	}
}