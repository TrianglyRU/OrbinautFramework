/// @function tile_get_angle(x, y, layer)
function tile_get_angle(X, Y, Layer)
{    
	// Get our current angle range
	var Range = round(Angle/90) % 4;
	
    // Get tile and its properties
    var Tile = tilemap_get_at_pixel(Stage.TileLayer[Layer], X, Y);
    var Flip = tile_get_flip(Tile);
    var Mirr = tile_get_mirror(Tile);
    
    // Get tile angle
	if Grounded
	{
	    if (Range mod 2) and Mirr or !(Range mod 2) and Flip 
	    {
	        Range = (Range + 2) mod 4;
	    }
	}
	else
	{
		Range = 0;
	}
    var FloorAng = Game.AngleValueOf[tile_get_index(Tile)][Range];
    
    // Adjust the angle
    if (Flip) FloorAng = (540 - FloorAng) mod 360;
    
    // Check if tile is mirrored and then return its angle
    return Mirr ? 360 - FloorAng : FloorAng;
}