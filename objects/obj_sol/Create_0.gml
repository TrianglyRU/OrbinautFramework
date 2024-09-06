#macro SOL_STATE_ROAM 0
#macro SOL_STATE_SHOOT 1

// Inherit the parent event
event_inherited();

state = SOL_STATE_ROAM;
fireball_count = 4;
angle = 0;
angle_step = 360 / fireball_count;
fireballs = [];

for (var i = 0; i < fireball_count; i++)
{
	var _new_angle = angle + angle_step * i;
	var _x = obj_oscillate_x(x, _new_angle, 16, 1, 0);
	var _y = obj_oscillate_y(y, _new_angle, 16, 1, 0);
	
	fireballs[i] = instance_create(_x, _y, obj_sol_fireball, {}, id);
}

obj_set_hitbox(6, 6);
obj_set_priority(4);
obj_set_culling(CULLING.RESPAWN);