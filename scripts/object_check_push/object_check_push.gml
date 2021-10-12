/// @function object_check_push(pushSide)
function object_check_push(pushSide)
{
	// Exit if collisions are disabled
	if !Player.AllowCollision
	{
		exit;
	}
	
	// Exit if no solid radiuses were initialized for this object
	if !variable_instance_exists(id, "Obj_SolidStatus")
	{
		exit;
	}
	
	// Exit if object is off-screen
	if !object_is_onscreen(id)
	{
		exit;
	}
	
	// Return push flag
	if Obj_SolidPush
	{
		switch pushSide
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