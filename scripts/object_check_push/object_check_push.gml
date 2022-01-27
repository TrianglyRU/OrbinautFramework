/// @function object_check_push(pushSide)
function object_check_push(pushSide)
{
	// Exit if can't be pushed
	if !Player.AllowCollision or !object_is_onscreen(id)
	{
		return false;
	}
	
	if pushSide == SideLeft  and floor(Player.PosX) < x
	or pushSide == SideRight and floor(Player.PosX) > x
	{
		return Obj_SolidPush;
	}
	return false;
}