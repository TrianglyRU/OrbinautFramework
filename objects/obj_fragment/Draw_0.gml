	
	// Override draw
	
	var _scale_x = FlipX ? -1 : 1;
	var _scale_y = FlipY ? -1 : 1;
	
	var _x = x - floor(Width / 2) * _scale_x;
	var _y = y - floor(Height / 2) * _scale_y;
	
	draw_sprite_part_ext
	(
		Sprite, FrameIndex, X, Y, Width, Height, floor(_x), floor(_y), _scale_x, _scale_y, c_white, 1.0
	);