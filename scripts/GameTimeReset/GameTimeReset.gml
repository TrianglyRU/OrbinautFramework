function GameTimeReset()
{
	// Reset global time and destroy data structure
	Game.GlobalTime = 0; ds_map_destroy(Game.SpriteTimers);
}