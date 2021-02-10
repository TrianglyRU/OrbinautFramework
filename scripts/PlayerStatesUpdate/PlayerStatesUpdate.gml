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
	if (HighSpeedBonus     > 0) HighSpeedBonus--;
	if (InvincibilityBonus > 0) InvincibilityBonus--;
	
	// Decrease invincibility timer
	if (isInvincible and !InvincibilityBonus) isInvincible--;
}