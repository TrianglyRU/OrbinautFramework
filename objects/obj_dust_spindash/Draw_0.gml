// Override draw
	
var _x = floor(TargetPlayer.x);
var _y = floor(TargetPlayer.y + TargetPlayer.radius_y);
	
draw_sprite_ext
(
	sprite_index, image_index, _x, _y, TargetPlayer.facing, image_yscale, image_angle, c_white, image_alpha
);