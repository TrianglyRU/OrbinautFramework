/// @function object_collide_tiles_v(xSide, ySide, minDistsance, tileLayer)
function object_collide_tiles_v(xSide, ySide, minDistance, tileLayer)
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
	var floorDistance = tile_check_collision_v(checkX, checkY, ySide = SideTop ? false : true, ySide = SideTop ? true : false, tileLayer)[0];
	
	// Check if the distance to the surface is less than the minimum distance
	if floorDistance <= minDistance
	{
		// Push the object to the surface if it is not too far in tiles
		if floorDistance >= -14 and floorDistance <= 14
		{
			y += floorDistance;
		}
		
		// Confirm collision
		return true;
	}
	
	// If the distance to the surface is greater than the minimum distance, object does not collide
	return false;
}