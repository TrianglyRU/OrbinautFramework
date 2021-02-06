/// @function tile_get_angle(x, y, layer)
function tile_get_angle(X, Y, Layer)
{    
    // Variable list
    var Tile, Ind, Range, Ang, Flip, Mirr;
    Range = round(Angle/90) % 4;
    
    // Get tile
    Tile = tilemap_get_at_pixel(Stage.TileLayer[Layer], X, Y);
    if (Tile = 0) return Range * 90;
    
    // Get its index on the tilemap
    Ind = tile_get_index(Tile) mod TileAmount;
    
    // Get our current angle range, ignore it for full tile
    if (Ind = 1) return Range * 90;
    
    // Get tile properties
    Flip = tile_get_flip(Tile);
    Mirr = tile_get_mirror(Tile);
    
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
    Ang = Game.AngleValueOf[Ind][Range];
    
    // Adjust the angle if tile is flipped
    if (Flip) Ang = (540 - Ang) mod 360;
    
    // Adjust the angle if tile is mirroed and then return it
    return Mirr ? 360 - Ang : Ang;
}