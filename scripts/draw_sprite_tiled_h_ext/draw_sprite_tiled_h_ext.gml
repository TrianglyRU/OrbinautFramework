/// @self
/// @description					This function will take a sprite and then repeatedly tile it across the given area horizontally.
/// @param {Asset.GMSprite} _sprite	The index of the sprite to draw.
/// @param {Real} _subimg			The frame of the sprite to draw.
/// @param {Real} _left				The x-position on the sprite of the top left corner of the area to draw.
/// @param {Real} _top				The y-position on the sprite of the top left corner of the area to draw.
/// @param {Real} _width			The width of the area to draw.
/// @param {Real} _height			The height of the area to draw.
/// @param {Real} _x				The x-coordinate of where to draw the sprite.
/// @param {Real} _y				The y-coordinate of where to draw the sprite.
/// @param {Real} _xscale			The horizontal scaling of the sprite.
/// @param {Real} _yscale			The vertical scaling of the sprite.
/// @param {Real} _colour			The colour with witch to blend the sprite.
/// @param {Real} _alpha			The alpha of the sprite.
/// @param {Real} _limit_left		The left limit of the area in which the sprite should be tiled. 
/// @param {Real} _limit_right		The right limit of the area in which the sprite should be tiled.
function draw_sprite_tiled_h_ext(_sprite, _subimg, _left, _top, _width, _height, _x, _y, _xscale, _yscale, _colour, _alpha, _limit_left, _limit_right)
{
    var _scaled_w = _width * _xscale;
    var _scaled_off = sprite_get_xoffset(_sprite) * _xscale;
    
    if _scaled_w == 0
	{
		return;
	}
    
    var _phase = ((_x - _limit_left) % _scaled_w + _scaled_w) % _scaled_w;
    var _cur_x = _limit_left + _phase - _scaled_w;
    
    while _cur_x - _scaled_off < _limit_right
    {
        if _cur_x - _scaled_off + _scaled_w > _limit_left
        {
            draw_sprite_general(_sprite, _subimg, _left, _top, _width, _height, _cur_x, _y, _xscale, _yscale, 0.0, _colour, _colour, _colour, _colour, _alpha);
        }
		
        _cur_x += _scaled_w;
    }
}