function StageTiledataLoad() 
{	
	// Load angle data
	read_file("data_angval.txt");
	
	// Load height data
	read_file("data_height.txt");
	
	// Load width data
	read_file("data_width.txt");
	
	// Set tile layers IDs
	TileLayer = [layer_tilemap_get_id("CollisionTilesA"), layer_tilemap_get_id("CollisionTilesB")];
}