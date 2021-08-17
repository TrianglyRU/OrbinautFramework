/// @function object_collide_tiles_v(xside, yside, maxdistance, layer)
function object_collide_tiles_v(xside, yside, maxdistance, layer)
{	
	// Exit the code if solidbox is not specified
	if !variable_instance_exists(id, "Obj_SolidStatus")
	{
		exit;
	}

	// Define xside
	switch xside
	{
		case SideLeft:   
			var CheckX = x - Obj_SolidX;     
		break;
		case SideRight: 
			var CheckX = x + Obj_SolidX - 1; 
		break;
		case SideCentre:
			var CheckX = x;				         
		break;
		default: 
			var CheckX = x; 
		break;
	}
	
	// Define yside
	switch yside
	{
		case SideTop:   
			var CheckY = y - Obj_SolidY;     
		break;
		case SideBottom: 
			var CheckY = y + Obj_SolidY - 1; 
		break;
		case SideCentre: 
			var CheckY = y;						 
		break;
		default: 
			var CheckY = y; 
		break;
	}
	
	var Direction = yside == SideTop ? -1 : 1;
	
	// Get distance to surface
	var FloorDistance  = tile_check_collision_v(CheckX, CheckY, Direction, !Direction, layer)[0];
	if  FloorDistance <= abs(maxdistance)
	{
		if FloorDistance >= -14
		{
			y += FloorDistance;
		}
		return true;
	}
	return false;
}