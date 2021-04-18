/// @function object_collide_tiles_h(xSide, ySide, minDistance, tileLayer)
function object_collide_tiles_h(xSide, ySide, minDistance, tileLayer)
{	
	// Check if this object radiuses were initialized
	if !variable_instance_exists(id, "objYRadiusSolid")
	{
		show_message("Object ID " + string(id) + " does not have any solidbox radiuses to collide with tiles! Please, call 'object_set_solidbox' function in Create event");
		game_end();
		exit;
	}
	
	// Define xside
	switch xSide
	{
		case SideLeft:   var checkX = floor(x - objXRadiusSolid);     break;
		case SideRight:  var checkX = floor(x + objXRadiusSolid - 1); break;
		
		// Use object centre if no side set
		default: var checkX = floor(x);	break;
	}
	
	// Define yside
	switch ySide
	{
		case SideTop :    var checkY = floor(y - objYRadiusSolid);     break;
		case SideBottom : var checkY = floor(y + objYRadiusSolid - 1); break;
		
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