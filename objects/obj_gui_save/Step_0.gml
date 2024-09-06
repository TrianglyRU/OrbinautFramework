if timer == 60
{
	instance_destroy();
}
else
{
	ani_run_by_timer(timer, 3);
}

timer++;
