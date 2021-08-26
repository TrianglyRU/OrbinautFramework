function GameCollisionsSetup()
{
	switch room
	{
		// Default collision
		default:
		{
			Game.TileData   = ["Default", 146];
			Game.TileLayers = ["CollisionLayerA", "CollisionLayerB"];	
		}
		break;
	}
}