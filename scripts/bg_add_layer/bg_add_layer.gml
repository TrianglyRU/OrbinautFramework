/// @self
/// @description Adds a parallax layer to the background of the current room.
/// @param {Asset.GMSprite} sprite_id The sprite asset to be used for the layer.
/// @param {Real} draw_node The y position on the sprite of the top edge of the area to draw.
/// @param {Real} draw_height The height of the area to draw.
/// @param {Real} pos_offset The vertical offset of the layer.
/// @param {Real} ani_duration The duration of each frame of the layer’s animation, in game steps.
/// @param {Real} scroll_vel_x The horizontal scroll speed of the layer’s content.
/// @param {Real} scroll_vel_y The vertical scroll speed of the layer’s content.
/// @param {Real} factor_x The horizontal parallax factor. Lower values make the layer appear further from the camera.
/// @param {Real} factor_y The vertical parallax factor. Lower values make the layer appear further from the camera.
function bg_add_layer(_sprite_id, _draw_node, _draw_height, _pos_offset, _ani_duration, _scroll_vel_x, _scroll_vel_y, _factor_x, _factor_y)
{	
	var _background = c_framework.background;
	
	// Сreate a new layer
	var _id = _background.layer_count++;
	var _sprite_texture = sprite_get_texture(_sprite_id, 0);
	
	// Set up parallax data for the new layer
	_background.parallax_data[_id] =
	{
		sprite: _sprite_id,
		node_y: _draw_node,
		height_y: _draw_height,
		offset_y: _pos_offset,
		factor_x: _factor_x,
		factor_y: _factor_y,
		scroll_vel_x: _scroll_vel_x,
		scroll_vel_y: _scroll_vel_y,
		scroll_x: 0,
		scroll_y: 0,
		field_line_height: 0,
		field_line_step: 0,
		ani_duration: _ani_duration,
		tex_width: sprite_get_width(_sprite_id),
		map_size_x: 1 / texture_get_texel_width(_sprite_texture),
		map_size_y: 1 / texture_get_texel_height(_sprite_texture),
	};
	
	if _background.min_factor_y == 0 || _factor_y < _background.min_factor_y
	{
		_background.min_factor_y = _factor_y;
	}
	
	// Set sprite offset
	sprite_set_offset(_sprite_id, 0, 0);
}
