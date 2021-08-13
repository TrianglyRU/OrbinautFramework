/// @function object_collide_tiles_h(xSide, ySide, minDistance, tileLayer)
function object_collide_tiles_h(xSide, ySide, minDistance, tileLayer)
{	
	// Exit the code if solidbox is not specified
	if !variable_instance_exists(id, "Obj_SolidStatus")
	{
		exit;
	}
	
	// Check if custom position variables are defined
	var XPos = variable_instance_exists(id, "PosX") ? PosX : x;
	var YPos = variable_instance_exists(id, "PosY") ? PosY : y;
	
	// Define xside
	switch xSide
	{
		case SideLeft:   
			var checkX = floor(XPos - Obj_SolidX);    
		break;
		case SideRight:  
			var checkX = floor(XPos + Obj_SolidX - 1); 
		break;
		case SideCentre: 
			var checkX = floor(XPos);				    
		break;
		default: 
			var checkX = floor(XPos);
		break;
	}
	
	// Define yside
	switch ySide
	{
		case SideTop:    
			var checkY = floor(YPos - Obj_SolidY); 
		break;
		case SideBottom: 
			var checkY = floor(YPos + Obj_SolidY - 1); 
		break;
		case SideCentre:
			var checkY = floor(YPos);				   
		break;
		default:
			var checkY = floor(YPos); 
		break;
	}
	
	// Get distance to surface
	var dirCheck     = xSide = SideLeft ? -1 : 1;
	var wallDistance = tile_check_collision_h(checkX, checkY, dirCheck, true, tileLayer)[0];

	// Check if the distance to the surface is less than the minimum distance
	if wallDistance <= minDistance
	{
		// Push the object to the surface if it is not too far in tiles
		if variable_instance_exists(id, "PosX")
		{
			PosX += wallDistance * dirCheck;
		}
		else
		{
			x += wallDistance;
		}
		
		// Confirm collision
		return true;
	}

	// If the distance to the surface is greater than the minimum distance, object does not collide
	return false;
}