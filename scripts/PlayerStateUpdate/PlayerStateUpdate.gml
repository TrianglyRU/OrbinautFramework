function PlayerStateUpdate()
{
	if Grounded
	{
		State = !Rolling ? StateNormal : StateRolling;
	}
	else
	{
		State = StateAirborne;
	}
}