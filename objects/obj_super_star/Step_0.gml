if !instance_exists(player) || player.super_timer <= 0
{
	if image_index == SUPER_STAR_LAST_FRAME
	{
		instance_destroy();
	}
}
else if player.action != ACTION.DASH && abs(player.spd) >= player.acc_top
{
	if animator.timer <= 0
	{
		animator.start(sprite_index, 0, 0, 2);
	}
	
	if animator.play_count == 0 || animator.duration == animator.timer && image_index == 0
	{
		x = player.x;
		y = player.y;
	}
}
else if image_index == SUPER_STAR_LAST_FRAME && animator.timer >= 0
{
	animator.clear(image_index);
}