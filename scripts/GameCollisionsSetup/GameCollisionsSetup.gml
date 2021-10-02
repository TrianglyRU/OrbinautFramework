function GameCollisionsSetup()
{
	switch room
	{
		// Default collision
		default:
			tile_data_set("", 146, "CollisionLayerA", "CollisionLayerB");
		break;
	}
}