/// @self
/// @description						Creates a new piece instance with custom sprite, size, position, velocity, and visual properties.
/// @param {Real} _x					The x-position for the piece instance.
/// @param {Real} _y					The y-position for the piece instance.
/// @param {Asset.GMSprite} _spriteid	The sprite to assign to the piece.
/// @param {Real} _image_index			The starting image index for the sprite.
/// @param {Real} _startx				The starting draw x-offset.
/// @param {Real} _starty				The starting draw y-offset.
/// @param {Real} _w					The width of the piece.
/// @param {Real} _h					The height of the piece.
/// @param {Real} _vel_x				The horizontal velocity of the piece.
/// @param {Real} _vel_y				The vertical velocity of the piece.
/// @param {Real} _delay				The delay before the piece becomes active.
/// @param {Bool} _flip_x				Whether to flip the piece horizontally.
/// @param {Bool} _flip_y				Whether to flip the piece vertically.
/// @param {Bool} _flicker				Whether or how the piece flickers.
function instance_create_piece(_x, _y, _spriteid, _image_index, _startx, _starty, _w, _h, _vel_x, _vel_y, _delay, _flip_x, _flip_y, _flicker)
{
	with instance_create(_x, _y, obj_piece)
	{
		sprite_index = _spriteid;
		image_index = _image_index;
		draw_start_x = _startx;
		draw_start_y = _starty;
		draw_width = _w;
		draw_height = _h;
		vel_x = _vel_x;
		vel_y = _vel_y;
		wait_time = _delay;
		flip_x = _flip_x;
		flip_y = _flip_y;
		flicker = _flicker;
	}
}