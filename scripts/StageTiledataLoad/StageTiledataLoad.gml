function StageTiledataLoad() 
{	
	// Load tile angle data
	read_file("data_angval.txt");
	
	// Load tile height data
	read_file("data_height.txt");
	
	// Load tile width data
	read_file("data_width.txt");
	
	// Set tile layers IDs
	TileLayer = [layer_tilemap_get_id("CollisionTilesA"), layer_tilemap_get_id("CollisionTilesB")];
}