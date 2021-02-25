function ObjBreakableWallScript()
{
	// Set object solidity based on player's inertia and rolling state
	if Player.Rolling and abs(Player.Inertia) >= 4
	{
		object_initialize(SolidNone);
	}
	else
	{
		object_initialize(SolidAll);
	}
}