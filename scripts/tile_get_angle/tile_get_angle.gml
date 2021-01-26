/// @function tile_get_angle_tiles(isCeiling, sensor)
function tile_get_angle_tiles(isCeiling, Sensor) 
{	
	// Get sensors anchor points
	var TileX = floor(Sensor[0]);
	var TileY = floor(Sensor[1]);
	
	// Get an angle of the tile
	var Tile = tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id(StageCollision)), TileX, TileY);
	var Angle = Game.AngleValueOf[tile_get_index(Tile)][Player.CollisionMode];
	
	// Return an angle and also check if it is mirrored
	return tile_get_mirror(Tile) ? 360 - Angle : Angle;
}