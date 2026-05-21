for (var _i = 0; _i < iv_chains; _i++)
{
	var _x = math_oscillate_x(xstart, osc_angle, _i * SWING_CHAIN_SIZE);
	var _y = math_oscillate_y(ystart, osc_angle, _i * SWING_CHAIN_SIZE);
	
	draw_sprite(sprite_chain, 0, _x, _y);
}

draw_sprite(sprite_pendulum, 0, xstart, ystart);

// Draw self
event_inherited();