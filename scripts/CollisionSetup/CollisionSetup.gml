/// @ Called in Framework Controller -> Room Start Event
function CollisionSetup()
{
	/* Default Tileset: 250 tiles
	   S1 Tileset: 247 tiles
	   S2 Tileset: 220 tiles
	   S3 Tileset: 249 tiles */
		
	switch room
	{
		case Stage_TSZ:
			tile_data_set("", 250, "CollisionLayerA", "CollisionLayerB");
		break;
		default:
			tile_data_set(noone, "", "", "");
	}
}