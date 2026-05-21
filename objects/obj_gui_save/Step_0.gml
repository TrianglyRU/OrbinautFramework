if timer == 60
{
	instance_destroy();
}
else
{
	instance_animate(timer, 3);
}

timer++;