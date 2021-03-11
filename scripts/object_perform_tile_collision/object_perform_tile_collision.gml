/// @function object_perform_tile_collision(xLeft, yLeft, xRight, yRight, angRange)
function object_perform_tile_collision(xLeft, yLeft, xRight, yRight, angRange)
{	
	// Report script error if wrong argument set
	if angRange > 3
	{
		show_message("Wrong angRange argument set in 'object_perform_tile_collision' function for object ID " + string(id) + ". Expected 0 (RangeFloor), 1 (RangeRWall), 2 (RangeRoof) or 3 (RangeLWall)");
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
			var distLeft  = tile_get_distance_v(xLeft, yLeft, colLayer, true, false);
			var distRight = tile_get_distance_v(xRight, yRight, colLayer, true, false);
			
			// Collide using closest one
			var Distance = distLeft <= distRight ? distLeft : distRight;
			if  Distance < 14 and Distance > -14
			{
				y += Distance;	
			}
		}
		break;
		case RangeRWall:
		{
			// Get floor distances
			var distLeft  = tile_get_distance_h(xLeft, yLeft, colLayer, true, false);
			var distRight = tile_get_distance_h(xRight, yRight, colLayer, true, false);
			
			// Collide using closest one
			var Distance = distLeft <= distRight ? distLeft : distRight;
			if  Distance < 14 and Distance > -14
			{
				x += Distance;
			}
		}
		break;
		case RangeRoof:
		{	
			// Get floor distances
			var distLeft  = tile_get_distance_v(xLeft, yLeft, colLayer, false, false);
			var distRight = tile_get_distance_v(xRight, yRight, colLayer, false, false);
			
			// Collide using closest one
			var Distance = distLeft <= distRight ? distLeft : distRight;
			if  Distance < 14 and Distance > -14
			{
				y -= Distance;
			}
		}
		break;
		case RangeLWall:
		{
			// Get floor distances
			var distLeft  = tile_get_distance_h(xLeft, yLeft, colLayer, false, false);
			var distRight = tile_get_distance_h(xRight, yRight, colLayer, false, false);
			
			// Collide using closest one
			var Distance = distLeft <= distRight ? distLeft : distRight;
			if  Distance < 14 and Distance > -14
			{
				x -= Distance;
			}
		}
		break;		
	}	
}