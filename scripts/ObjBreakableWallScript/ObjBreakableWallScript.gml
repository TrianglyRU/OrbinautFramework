function ObjBreakableWallScript()
{
	// Set object solidity based on player's inertia and rolling state
	if Player.Rolling and abs(Player.Inertia) >= 4
	{
		object_set_type(SolidNone);
	}
	else
	{
		object_set_type(SolidAll);
	}
}