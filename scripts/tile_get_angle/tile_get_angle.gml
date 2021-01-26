/// @function tile_get_angle_tiles(isCeiling)
/*function tile_get_angle_tiles(isCeiling) 
{	
	// Get sensors anchor points
	var id1 = isCeiling ? CLG_L : FLR_L;
	var id2 = isCeiling ? CLG_R : FLR_R;
	var AX  = floor(Sensor[id1][0]);
	var AY  = floor(Sensor[id1][1]);
	var BX  = floor(Sensor[id2][0]);
	var BY  = floor(Sensor[id2][1]);
	
	// Choose the tile to read angle from
	switch tile_get_winning(AX, AY, BX, BY) {
		case "left":  
			var TileX = AX; 
			var TileY = AY; 
		break;
		case "right": 
			var TileX = BX; 
			var TileY = BY; 
		break;
		case "none": 
			return 360; 
		break;
	}
	
	// Get an angle of the tile
	var Tile = tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id(StageCollision)), TileX, TileY);
	var Ang = Game.AngleValueOf[tile_get_index(Tile)][Player.CollisionMode];
	
	// Return an angle and also check if it is mirrored
	return tile_get_mirror(Tile) ? 360 - Ang : Ang;
}*/