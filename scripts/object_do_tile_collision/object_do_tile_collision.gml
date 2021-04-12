/// @function object_do_tile_collision(xLeft, yLeft, xRight, yRight, angRange)
function object_do_tile_collision(xLeft, yLeft, xRight, yRight, angRange)
{	
	// Report script error if wrong argument set
	if angRange > 3
	{
		show_message("Wrong angRange argument set in 'object_check_tile' function for object ID " + string(id) + ". Expected 0 (RangeFloor), 1 (RangeRWall), 2 (RangeRoof) or 3 (RangeLWall)");
		game_end();
	}
	
	// Get collision layers
	var colLayer = Stage.TileLayer[LayerA] or Stage.TileLayer[LayerB];
	
	// Collide based on given angle range
	switch angRange
	{
		case RangeFloor:
		{	
			// Get floor distances
			var dLeft  = tile_check_collision_v(xLeft, yLeft, true, false, colLayer);
			var dRight = tile_check_collision_v(xRight, yRight, true, false, colLayer);
			
			// Collide using closest one
			var floorDistance = dLeft[0] <= dRight[0] ? dLeft[0] : dRight[0];
			if  floorDistance < 14 and floorDistance > -14
			{
				y += floorDistance;	
			}
		}
		break;
	}	
}