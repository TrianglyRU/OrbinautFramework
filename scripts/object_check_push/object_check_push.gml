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
	var RX = sprite_get_width(sprite_index)  / 2;
	var RY = sprite_get_height(sprite_index) / 2;
	
	if x + RX < Camera.ViewX or x - RX > Camera.ViewX + Game.Width
	or y + RY < Camera.ViewY or y - RY > Camera.ViewY + Game.Height
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