/// @function object_collide_tiles_v(xSide, ySide, minDistsance, tileLayer)
function object_collide_tiles_v(xSide, ySide, minDistance, tileLayer)
{	
	// Exit the code if solidbox is not specified
	if !variable_instance_exists(id, "objYRadiusSolid")
	{
		exit;
	}
	
	// Check if custom position variables are defined
	var XPos = variable_instance_exists(id, "PosX") ? PosX : x;
	var YPos = variable_instance_exists(id, "PosY") ? PosY : y;
	
	// Define xside
	switch xSide
	{
		case SideLeft:   var checkX = floor(XPos - objXRadiusSolid);     break;
		case SideRight:  var checkX = floor(XPos + objXRadiusSolid - 1); break;
		case SideCentre: var checkX = floor(XPos);				         break;
		
		// Use object X centre if no specific side is specified
		default: var checkX = floor(XPos); break;
	}
	
	// Define yside
	switch ySide
	{
		case SideTop:    var checkY = floor(YPos - objYRadiusSolid);     break;
		case SideBottom: var checkY = floor(YPos + objYRadiusSolid - 1); break;
		case SideCentre: var checkY = floor(YPos);						 break;
		
		// Use object Y centre if no specific side is specified
		default: var checkY = floor(YPos); break;
	}
	
	// Get distance to surface
	var floorDistance = tile_check_collision_v(checkX, checkY, ySide = SideTop ? false : true, ySide = SideTop ? true : false, tileLayer)[0];
	
	// Check if the distance to the surface is less than the minimum distance
	if floorDistance <= minDistance
	{
		// Push the object to the surface if it is not too far in tiles
		if floorDistance >= -14 and floorDistance <= 14
		{
			if variable_instance_exists(id, "PosY")
			{
				PosY += floorDistance;
			}
			else
			{
				y += floorDistance;
			}
		}
		
		// Confirm collision
		return true;
	}
	
	// If the distance to the surface is greater than the minimum distance, object does not collide
	return false;
}