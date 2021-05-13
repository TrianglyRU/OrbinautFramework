/// @function object_collide_tiles_h(xSide, ySide, minDistance, tileLayer)
function object_collide_tiles_h(xSide, ySide, minDistance, tileLayer)
{	
	// Exit the code if this object solidbox wasn't initialized
	if (!variable_instance_exists(id, "objYRadiusSolid")) exit;
	
	// Define xside
	switch xSide
	{
		case SideLeft:   var checkX = floor(x - objXRadiusSolid);     break;
		case SideRight:  var checkX = floor(x + objXRadiusSolid - 1); break;
		case SideCentre: var checkX = floor(x);				          break;
		
		// Use object centre if no side set
		default: var checkX = floor(x);	break;
	}
	
	// Define yside
	switch ySide
	{
		case SideTop:    var checkY = floor(y - objYRadiusSolid);     break;
		case SideBottom: var checkY = floor(y + objYRadiusSolid - 1); break;
		case SideCentre: var checkY = floor(y);						  break;
		
		// Use object centre if no side set
		default: var checkY = floor(y); break;
	}
	
	// Get tile distance
	var wallDistance = tile_check_collision_h(checkX, checkY, xSide = SideLeft ? false : true, true, tileLayer)[0];

	// Update object position
	if wallDistance <= minDistance
	{
		x += wallDistance;
		return true;
	}
	
	return false;
}