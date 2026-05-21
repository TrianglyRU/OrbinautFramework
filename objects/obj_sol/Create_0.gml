// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.RESET);

enum SOL_STATE
{
	ROAM,
	SHOOT
}

#macro SOL_FIREBALL_COUNT 4

depth = draw_depth(40);
state = SOL_STATE.ROAM;
angle = 0;
angle_step = 360 / SOL_FIREBALL_COUNT;
fireballs = array_create(SOL_FIREBALL_COUNT, noone);

for (var _i = 0; _i < SOL_FIREBALL_COUNT; _i++)
{
	var _new_angle = angle + angle_step * _i;
	var _x = math_oscillate_x(x, _new_angle, 16);
	var _y = math_oscillate_y(y, _new_angle, 16);
	
	fireballs[_i] = instance_create(_x, _y, obj_sol_fireball);
}