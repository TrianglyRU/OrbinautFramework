/// @function object_perform_tile_collision(xLeft, yLeft, xRight, yRight, angRange)
function object_perform_tile_collision(xLeft, yLeft, xRight, yRight, angRange)
{
	// Get collision layers
	var colLayer = Stage.TileLayer[LayerA] or Stage.TileLayer[LayerB];
	
	// Collide based on given angle range
	switch angRange
	{
		case RangeFloor:
		{	
			// Get distances
			var distLeft  = tile_get_distance_v(xLeft, yLeft, colLayer, true, false);
			var distRight = tile_get_distance_v(xRight, yRight, colLayer, true, false);
			
			// Collide using closest one
			if distLeft <= distRight
			{
				y += distLeft;
			}
			else
			{
				y += distRight;
			}	
		}
		break;
		case RangeRWall:
		{
			// Get distances
			var distLeft  = tile_get_distance_h(xLeft, yLeft, colLayer, true, false);
			var distRight = tile_get_distance_h(xRight, yRight, colLayer, true, false);
			
			// Collide using closest one
			if distLeft <= distRight
			{
				x += distLeft;
			}
			else
			{
				x += distRight;
			}
		}
		break;
		case RangeRoof:
		{	
			// Get distances
			var distLeft  = tile_get_distance_v(xLeft, yLeft, colLayer, false, false);
			var distRight = tile_get_distance_v(xRight, yRight, colLayer, false, false);
			
			// Collide using closest one
			if distLeft <= distRight
			{
				y -= distLeft;
			}
			else
			{
				y -= distRight;
			}	
		}
		break;
		case RangeLWall:
		{
			// Get distances
			var distLeft  = tile_get_distance_h(xLeft, yLeft, colLayer, false, false);
			var distRight = tile_get_distance_h(xRight, yRight, colLayer, false, false);
			
			// Collide using closest one
			if distLeft <= distRight
			{
				x -= distLeft;
			}
			else
			{
				x -= distRight;
			}
		}
		break;		
	}	
}