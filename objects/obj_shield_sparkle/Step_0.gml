visible = !visible;

if display_timer < 24
{
	instance_animate(display_timer++, 2);
	
	x += sparkle_index < 2 ? -2 : 2;
	y += sparkle_index % 2 == 0 ? -2 : 2;
}
else
{
	instance_destroy();
}