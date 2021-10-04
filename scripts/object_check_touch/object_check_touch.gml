/// @function object_check_touch(side)
function object_check_touch(side)
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
	
	// Return touch flag
	switch side
	{
		case SideTop:
			return Obj_SolidTouchU;
		break;
		case SideBottom:
			return Obj_SolidTouchD;
		break;
		case SideLeft:
			return Obj_SolidTouchL;
		break;
		case SideRight:
			return Obj_SolidTouchR;
		break;
	}
}