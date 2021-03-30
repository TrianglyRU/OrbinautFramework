function PlayerJumpResist()
{
	if Input.ABC == false and Jumping == true
	{
		if (Ysp < JumpMin) Ysp = JumpMin;
	}	
}