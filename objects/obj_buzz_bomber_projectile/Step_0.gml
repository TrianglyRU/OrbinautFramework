if !visible
{
	if --wait_timer < 0
	{
		visible = true;
		animator.start(sprite_index, 0, 1, 8);
	}
}
else if sprite_index != spr_badnik_projectile
{
	if animator.timer < 0
	{
		animator.start(spr_badnik_projectile, 0, 0, 2);
	}
}
else
{
	// Inherit the parent event
	event_inherited();
}