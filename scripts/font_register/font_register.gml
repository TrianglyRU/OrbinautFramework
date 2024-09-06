/// @self
/// @description Registers a sprite as a font. This acts as a wrapper for the `font_add_sprite_ext()` function.
/// @param {Asset.GMSprite} sprite_id The sprite asset containing the font characters.
/// @param {String} mapstring A string defining the arrangement of characters within the sprite.
/// @param {Real} cut_empty_space Whether to trim empty space around characters (requires "Automatically Crop" enabled in Texture Group Settings).
/// @param {Real} separation The spacing between individual characters in the font.
/// @returns {Asset.GMFont}
function font_register(_sprite_id, _mapstring, _cut_empty_space, _separation)
{
	sprite_set_offset(_sprite_id, 0, 0);
	return font_add_sprite_ext(_sprite_id, _mapstring, _cut_empty_space, _separation);
}