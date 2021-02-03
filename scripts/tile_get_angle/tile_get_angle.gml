/// @function tile_get_angle(x, y, layer)
function tile_get_angle(X, Y, Layer)
{    
    // Get tile
    var Tile = tilemap_get_at_pixel(Stage.TileLayer[Layer], X, Y);
	
	// Get its index on the tilemap
	var Ind  = tile_get_index(Tile) mod 192;
	if (!Ind) return 0;
	
	// Get our current angle range, ignore it for full tile
	var Range = round(Angle/90) % 4;
	if (Ind = 174) return Range * 90;
	
	// Get tile properties
    var Flip = tile_get_flip(Tile);
    var Mirr = tile_get_mirror(Tile);
    
    // Get angle range of the tile based on its properties
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
	
	// Get tile angle based on its range
    var Ang = Game.AngleValueOf[Ind][Range];
    
    // Adjust the angle if tile is flipped
    if (Flip) Ang = (540 - Ang) mod 360;
    
    // Adjust the angle if tile is mirroed and then return it
    return Mirr ? 360 - Ang : Ang;
}