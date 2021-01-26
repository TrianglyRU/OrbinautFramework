function object_set_depth(abovePlayer)
{
	if abovePlayer
	{
		depth = Player.DrawOrder - 1;
	}
	else
	{
		depth = Player.DrawOrder + 1;
	}
}