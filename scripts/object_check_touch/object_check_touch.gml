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