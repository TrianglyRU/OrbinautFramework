function AIJumpResist()
{
	if !Input.ABC and Jumping
	{
		if (Ysp < JumpMin) Ysp = JumpMin;
	}	
}