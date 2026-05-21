// Inherit the parent event
event_inherited();

y += vel_y;
vel_y += 0.09375;

if y >= ystart - 192
{
	if y >= ystart
	{
		y = ystart;
		vel_y = MASHER_VEL_Y_DEFAULT;
	}
	
	if vel_y >= 0
	{
		if animator.timer > 0
		{
			animator.clear(0);
		}
	}
	else if animator.timer == 0
	{
		animator.start(sprite_index, 0, 0, 8);
	}
}
else
{
	animator.duration = 4;
}