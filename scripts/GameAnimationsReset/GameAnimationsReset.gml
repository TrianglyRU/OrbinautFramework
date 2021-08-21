function GameAnimationsReset()
{
	// Ignore the animation method built into the IDE
	with all
	{
		sprite_set_speed(sprite_index, 0, spritespeed_framespergameframe);
	}
}