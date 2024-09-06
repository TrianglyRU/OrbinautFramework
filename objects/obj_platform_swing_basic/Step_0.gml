// Calculate oscillation angle based on frame counter and angle increment
osc_angle = dsin(c_framework.frame_counter * ANGLE_INCREMENT) * range;
	
x = obj_oscillate_x(xstart, osc_angle, distance, 1, ReverseMovement * 180);
y = obj_oscillate_y(ystart, osc_angle, distance, 1, false);
	
for (var p = 0; p < PLAYER_COUNT; p++)
{
	obj_act_solid(player_get(p), SOLIDOBJECT.TOP);
}