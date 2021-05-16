/// @function object_collide_tiles_h(xSide, ySide, minDistance, tileLayer)
function object_collide_tiles_h(xSide, ySide, minDistance, tileLayer)
{	
	// Exit the code if solidbox is not specified
	if (!variable_instance_exists(id, "objYRadiusSolid")) exit;
	
	// Define xside
	switch xSide
	{
		case SideLeft:   var checkX = floor(x - objXRadiusSolid);     break;
		case SideRight:  var checkX = floor(x + objXRadiusSolid - 1); break;
		case SideCentre: var checkX = floor(x);				          break;
		
		// Use object X centre if no specific side is specified
		default: var checkX = floor(x);	break;
	}
	
	// Define yside
	switch ySide
	{
		case SideTop:    var checkY = floor(y - objYRadiusSolid);     break;
		case SideBottom: var checkY = floor(y + objYRadiusSolid - 1); break;
		case SideCentre: var checkY = floor(y);						  break;
		
		// Use object Y centre if no specific side is specified
		default: var checkY = floor(y); break;
	}
	
	// Get distance to surface
	var wallDistance = tile_check_collision_h(checkX, checkY, xSide = SideLeft ? false : true, true, tileLayer)[0];

	// Check if the distance to the surface is less than the minimum distance
	if wallDistance <= minDistance
	{
		// Push the object to the surface if it is not too far in tiles
		if wallDistance >= -14 and wallDistance <= 14
		{
			x += wallDistance;
		}
		
		// Confirm collision
		return true;
	}

	// If the distance to the surface is greater than the minimum distance, object does not collide
	return false;
}