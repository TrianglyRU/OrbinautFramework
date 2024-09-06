if vel_y < 0
{
	y += vel_y;
	vel_y += 0.09375;
}
else
{
	instance_destroy();
}