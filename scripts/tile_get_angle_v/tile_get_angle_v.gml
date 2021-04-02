/// @function tile_get_angle_v(X, Y, toPositive, noSolidTop, Layer)
function tile_get_angle_v(X, Y, toPositive, noSolidTop, Layer)
{
	// Return angle value of 360 if we're out of stage boundaries
	if (X < 0 or Y < 0 or X > room_width or Y > room_height) return 360;	

	// Get tile and read its height
	var Tile  = tilemap_get(Stage.TileLayer[Layer], X div TileSize, Y div TileSize);
	var Index = tile_get_index(Tile) mod TileAmount;
	
	// Return cardinal angle for empty tile
	if (!Tile) return toPositive ? 360 : 180;
		
	// Return cardinal angle for flipped tiles
	var Flip = tile_get_flip(Tile);
	if toPositive and Flip 
	{
		return 360;
	}
	else if !toPositive and !Flip 
	{
		return 180;
	}
		
	// Get angle of regular tiles
	var Ang = Game.AngleValueOf[Index];
    
	// Adjust the angle and return it
	if Flip
	{
		Ang = (540 - Ang) mod 360;
	}
	return tile_get_mirror(Tile) ? 360 - Ang : Ang;
}