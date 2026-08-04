/// @self
/// @description									Loads the primary (A) and the secondary (B) palette data from two sprite textures.
/// @param {Real} _entry							The palette entry identifier.
/// @param {Asset.GMSprite} _palette_a				The primary palette sprite.
/// @param {Asset.GMSprite|Undefined} [_palette_b]	The secondary palette sprite (default is undefined).
function pal_load(_entry, _palette_a, _palette_b = undefined)
{
	var _sprites = [_palette_a, _palette_b];
	var _sprite_info;
	
	for (var _i = 0; _i < 2; _i++)
	{
		var _sprite = _sprites[_i];
		
		if _sprite != undefined
		{
			var _texture = sprite_get_texture(_sprite, 0);
			var _uvs = sprite_get_uvs(_sprite, 0);
			var _texel_w = texture_get_texel_width(_texture);
			var _texel_h = texture_get_texel_height(_texture);
			
			_sprite_info[_i] = [_texture, _texel_w, _texel_h, _uvs[0], _uvs[1], _uvs[3]]
		}
		else
		{
			_sprite_info[_i] = undefined;
		}
	}
	
	var _data =
	{
		durations: array_create(PALETTE_TOTAL_SLOT_COUNT, 0),
		timers: array_create(PALETTE_TOTAL_SLOT_COUNT, 0),
		indices: array_create(PALETTE_TOTAL_SLOT_COUNT, 1),
		loop_indices: array_create(PALETTE_TOTAL_SLOT_COUNT, 0),
		end_indices: array_create(PALETTE_TOTAL_SLOT_COUNT, 0),
	}
	
	obj_game.palette_maps[? _entry] = [_data, _sprite_info];
	obj_game.palette_maps_keys = ds_map_keys_to_array(obj_game.palette_maps);
}