/// @function tile_get_angle(x, y, layer)
function tile_get_angle(X, Y, Layer) 
{	
	// Get angle of the tile
	var Tile     = tilemap_get_at_pixel(Stage.TileLayer[Layer], X, Y);
	var FloorAng = Game.AngleValueOf[tile_get_index(Tile)][round(Angle/90) % 4];
	
	// Adjust the angle if tile is flipped
	if tile_get_flip(Tile)
	{
		FloorAng = (540 - FloorAng) mod 360;
	}
	
	// Check if tile is mirrored and then return its angle
	return tile_get_mirror(Tile) ? 360 - FloorAng : FloorAng;
}