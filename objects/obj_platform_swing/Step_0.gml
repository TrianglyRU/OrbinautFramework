osc_angle = dsin(obj_game.oscillation_angle + iv_offset) * iv_range * 0.5;

x = math_oscillate_x(xstart, osc_angle, distance);
y = math_oscillate_y(ystart, osc_angle, distance);

FOR_EACH_PLAYER
{
	solid_object(player_get(_p), SOLID_TYPE.TOP);
}