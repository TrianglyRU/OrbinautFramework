/// @function object_check_push(pushSide)
function object_check_push(pushSide)
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
	
	// Exit if no solid radiuses were initialized for this object
	if !variable_instance_exists(id, "Obj_SolidX")
	{
		return false;
	}
	
	// Return push flag
	if pushSide == SideLeft  and floor(Player.PosX) < x
	or pushSide == SideRight and floor(Player.PosX) > x
	{
		return Obj_SolidPush;
	}
	return false;
}