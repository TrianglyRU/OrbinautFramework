/// @self
/// @description						Registers a sprite as a font. This acts as a wrapper for the font_add_sprite_ext() function.
/// @param {Asset.GMSprite} _sprite_id	The sprite asset containing the font characters.
/// @param {String} _map_string			A string defining the arrangement of characters within the sprite.
/// @param {Real} _cut_empty_space		Whether to trim empty space around characters (requires "Automatically Crop" to be enabled in Texture Group Settings).
/// @param {Real} _separation			The spacing between individual characters in the font.
function font_register(_sprite_id, _map_string, _cut_empty_space, _separation)
{
	sprite_set_offset(_sprite_id, 0, 0);
	ds_map_add(global.font_data, _sprite_id, font_add_sprite_ext(_sprite_id, _map_string, _cut_empty_space, _separation));
}