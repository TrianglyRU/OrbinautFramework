/// @function tile_get_angle()
function tile_get_angle(sensor) 
{	
	// Get sensors anchor points
	var X = sensor[0];
	var Y = sensor[1];
	
	// Get an angle of the tile
	var Tile  = tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("CollisionTilesA")), X, Y);
	var Angle = Game.AngleValueOf[tile_get_index(Tile)][Player.CollisionMode];
	
	// Return an angle and also check if it is mirrored
	return tile_get_mirror(Tile) ? 360 - Angle : Angle;
}