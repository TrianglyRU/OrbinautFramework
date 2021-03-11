function ObjBreakableWallScript()
{
	// Set object CollisionType based on player's inertia and rolling state
	if Player.Rolling and abs(Player.Inertia) >= 4
	{
		object_set_collision(SolidNone);
	}
	else
	{
		object_set_collision(SolidAll);
	}
}