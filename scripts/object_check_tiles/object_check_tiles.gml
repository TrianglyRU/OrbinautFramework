/// @function object_check_tiles(xSide, ySide, tileLayer)
function object_check_tiles(xSide, ySide, tileLayer)
{	
	// Check if this object radiuses were initialized
	if !variable_instance_exists(id, "objXRadiusSolid")
	{
		show_message("Object ID " + string(id) + " does not have any solidbox radiuses to check for tiles! Please, call 'object_set_solidbox' function in Create event");
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
		case SideTop :    var checkY = floor(y - objYRadiusSolid); break;
		case SideBottom : var checkY = floor(y + objYRadiusSolid); break;
		
		// Use object centre if no side set
		default: var checkY = floor(y); break;
	}
	
	// Get tile distance
	var floorDistance = tile_check_collision_v(checkX, checkY, ySide = SolidTop ? false : true, ySide = SolidTop ? true : false, tileLayer)[0];
			
	// Return check result
	return floorDistance <= 0;
}