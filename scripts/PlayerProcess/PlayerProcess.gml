function PlayerProcess()
{
	// Do not process player if stage is inactive
	if !Stage.DoUpdate
	{
		return false;
	}
	
	// Get player state
	if !Player.Grounded
	{
		Player.State = StateAirborne;
	}
	else if Player.Grounded and !Player.Spinning
	{
		Player.State = StateGrounded;
	}
	else if Player.Grounded and Player.Spinning
	{
		Player.State = StateRolling;
	}
	
	// Process player
	return true;
}