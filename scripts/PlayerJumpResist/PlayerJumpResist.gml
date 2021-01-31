function PlayerJumpResist()
{
	if !Input.ABC and Jumping 
	{
		if (Ysp < -4) Ysp = -4;
	}	
}