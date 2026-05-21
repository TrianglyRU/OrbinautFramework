image_index = combo < 4 ? combo : (combo < 16 ? 4 : 5);

if vel_y < 0
{
	y += vel_y;
	vel_y += 0.09375;
}
else
{
	instance_destroy();
}