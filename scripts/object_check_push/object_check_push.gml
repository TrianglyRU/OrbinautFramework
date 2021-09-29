/// @function object_check_push(pushSide)
function object_check_push(pushSide)
{
	// Exit if collisions are disabled
	if !Player.AllowCollision
	{
		exit;
	}
	
	// Exit if object is off-screen
	if x < Camera.ViewX - 32 or x > Camera.ViewX + Game.Width  + 32
	or y < Camera.ViewY - 32 or y > Camera.ViewY + Game.Height + 32
	{
		exit;
	}
	
	// Exit if no solid radiuses were initialized for this object
	if !variable_instance_exists(id, "Obj_SolidStatus")
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