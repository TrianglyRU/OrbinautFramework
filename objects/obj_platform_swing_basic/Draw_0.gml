// Draw the chain sprites
for (var i = 0; i < ChainAmount; i++)
{
	var _x = obj_oscillate_x(xstart, osc_angle, i * chain_size, 1, ReverseMovement * 180);
	var _y = obj_oscillate_y(ystart, osc_angle, i * chain_size, 1, 0);
	draw_sprite(ChainSprite, 0, _x, _y);
}

// Draw the pendulum sprite and self
draw_sprite(BobSprite, 0, xstart, ystart);
draw_self();