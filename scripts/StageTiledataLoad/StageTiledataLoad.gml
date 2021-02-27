function StageTiledataLoad() 
{	
	// Load tile angle data
	data_read("data_angval.txt");
	
	// Load tile height data
	data_read("data_height.txt");
	
	// Load tile width data
	data_read("data_width.txt");
	
	// Set tile layers IDs
	TileLayer = [layer_tilemap_get_id("CollisionTilesA"), layer_tilemap_get_id("CollisionTilesB")];
}