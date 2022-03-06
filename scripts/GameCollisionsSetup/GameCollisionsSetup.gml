function GameCollisionsSetup()
{
	switch room
	{
		case Stage_TSZ:
			tile_data_set("", 145, "CollisionLayerA", "CollisionLayerB");
		break;
		default:
			tile_data_set(noone, "", "", "");
	}
}