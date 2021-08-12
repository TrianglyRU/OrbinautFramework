function ObjBreakableWallScript()
{
	if Player.Spinning and abs(Player.Inertia) > 4 
	{
		if Player.Xsp > 0 and object_player_touch(SideLeft)
		or Player.Xsp < 0 and object_player_touch(SideRight)
		{
			instance_destroy();
		}
	}
	else
	{
		// Do collision
		object_act_solid(true, false, false);
	}
}