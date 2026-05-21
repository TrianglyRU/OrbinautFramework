x += vel_x;
y += vel_y;

if vel_x != 0
{
	if !instance_is_drawn()
	{
		instance_destroy();
	}
	else
	{
		vel_y += GLOBAL_PARAM_GRV;
	}
}