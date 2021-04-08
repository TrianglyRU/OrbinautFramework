function object_check_touch(collisionSide)
{
	// Check if this object radiuses were initialized
	if !variable_instance_exists(id, "objXRadiusSolid")
	{
		show_message("Object ID " + string(id) + " does not have any solidbox radiuses to check for collision with player! Please, call 'object_set_solidbox' function in Create event");
		game_end();
		exit;
	}
	
	// Return collision result
	switch collisionSide
	{
		case SideTop:    return objTouchedTop;    break;
		case SideLeft:   return objTouchedLeft;   break;
		case SideRight:  return objTouchedRight;  break;
		case SideBottom: return objTouchedBottom; break;
	}
}