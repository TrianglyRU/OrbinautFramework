function GameCollisionsSetup()
{
	switch room
	{
		case Stage_TZ:
			tile_data_set("TZ", 66, "CollisionLayerA", "CollisionLayerB");
		break;
		default:
			tile_data_set(noone, "", "", "");
		break;
	}
}