function GameCollisionsSetup()
{
	switch room
	{
		// Default collision
		default:
		{
			Game.TileData   = ["", 146];
			Game.TileLayers = ["CollisionLayerA", "CollisionLayerB"];	
		}
		break;
	}
}