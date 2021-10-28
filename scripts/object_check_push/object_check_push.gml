/// @function object_check_push(pushSide)
function object_check_push(pushSide)
{
	// Return push flag
	if pushSide == SideLeft  and floor(Player.PosX) < x
	or pushSide == SideRight and floor(Player.PosX) > x
	{
		return Obj_SolidPush;
	}
	return false;
}