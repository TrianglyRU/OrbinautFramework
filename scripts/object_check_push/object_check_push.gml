/// @function object_check_push(side)
function object_check_push(side)
{
	// Exit the code if collisions are disabled
	if !Player.AllowCollision
	{
		exit;
	}
	
	// Exit the code if no solid radiuses were initialized for this object
	if !variable_instance_exists(id, "Obj_SolidStatus")
	{
		exit;
	}
	
	// Return push flag
	if Obj_SolidPush
	{
		switch side
		{
			case SideLeft:
				return floor(Player.PosX) < x;
			break;
			case SideRight:
				return floor(Player.PosX) > x;
			break;
			default:
				return false;
			break;
		}
	}
	return false;
}