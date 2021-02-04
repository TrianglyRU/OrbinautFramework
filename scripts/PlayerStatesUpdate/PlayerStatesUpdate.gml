function PlayerStatesUpdate()
{
	// Update main state
	if Grounded
	{
		State = !Rolling ? PlayerStateNormal : PlayerStateRoll;
	}
	else
	{
		State = PlayerStateAirborne;
	}
	
	// Update bonuses state
	if (HighSpeedBonus > 0) HighSpeedBonus--;
}