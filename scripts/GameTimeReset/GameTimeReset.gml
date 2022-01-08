function GameTimeReset()
{
	// Reset global time
	Game.GlobalTime = 0;
	
	// Destroy data structure
	ds_map_destroy(Game.SpriteTimers);
}