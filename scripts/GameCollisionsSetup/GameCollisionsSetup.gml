function GameCollisionsSetup()
{
	switch room
	{
		// Test Stage
		case Stage_TZ:
			tile_data_set("TZ", 47, "CollisionLayerA", "CollisionLayerB");
		break;
		
		// Default
		default:
			tile_data_set("", 146, "CollisionLayerA", "CollisionLayerB");
		break;
	}
}