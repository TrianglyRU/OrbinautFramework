/// @function object_check_touch(side)
function object_check_touch(side)
{
	// Exit if collisions are disabled
	if !Player.AllowCollision
	{
		return false;
	}
	
	// Exit if object is off-screen
	if !object_is_onscreen(id)
	{
		return false;
	}
	
	// Return touch flag
	switch side
	{
		case SideTop:
			return Obj_SolidTouchU or Player.OnObject == id;
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