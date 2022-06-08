/// @ Called in Framework Controller -> Room Start Event
function CollisionSetup()
{
	switch room
	{
		case Stage_TSZ:
			tile_data_set("", TileCount, "CollisionLayerA", "CollisionLayerB");
		break;
		default:
			tile_data_set(noone, "", "", "");
	}
}