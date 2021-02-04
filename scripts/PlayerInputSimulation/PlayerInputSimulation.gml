function PlayerMovementLock() 
{	
	// Double input lock emulation
	if Input.Left and Input.Right 
	{
		if !Rolling 
		{ 
			Facing = FacingRight;
		} 
		else 
		{
			Input.Left  = false;
			Input.Right = false;
		}
	}
	if Input.Up and Input.Down and SpindashRev < 0 
	{
		Input.Down = false;
	}
	
	
}