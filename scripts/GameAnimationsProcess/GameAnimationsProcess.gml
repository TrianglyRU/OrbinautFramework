function GameAnimationsProcess()
{
	// Ignore in-built animation speed for all instances
	with all
	{
		sprite_set_speed(sprite_index, 0, spritespeed_framespergameframe);
	}
	
	// Count room animation timer
	if !fade_check(FadeActive) and !variable_check(Stage, "IsPaused")
	{
		Game.AnimationTime++;
	}
}