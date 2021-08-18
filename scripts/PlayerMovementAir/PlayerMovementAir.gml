function PlayerMovementAir()
{	
	// Rotate angle back to 360 degrees
	if Player.Angle < 180
	{
		Player.Angle = max(Player.Angle - 2.8125, 0);
	}
	else
	{
		Player.Angle = min(Player.Angle + 2.8125, 360);
	}
	
	// Exit if gliding (ignoring GlideDrop state) or climbing
	if Player.GlideState == GlideActive or Player.GlideState == GlideStop 
	or Player.ClimbState
	{
		exit;
	}
	
	// Handle air movement
	if !(Player.RollJumping and !Game.RolljumpControl) and !Player.NoControls
	{
		// Holding left
		if Input.Left 
		{	
			// Decelerate
			if Player.Xsp > 0 
			{
				Player.Xsp -= AirAcc;
			} 
			
			// Accelerate
			else if !Game.AirSpeedcap and Player.Xsp > -Player.TopAcc or Game.AirSpeedcap
			{
				Player.Xsp -= AirAcc;
				if Player.Xsp <= -Player.TopAcc
				{
					Player.Xsp = -Player.TopAcc;
				}
			}
			Player.Facing = FlipLeft;
		}
		
		// Holding right
		else if Input.Right 
		{	
			// Decelerate
			if Player.Xsp < 0 
			{
				Player.Xsp += Player.AirAcc;
			} 
			
			// Accelerate
			else if (!Game.AirSpeedcap and Player.Xsp < Player.TopAcc) or Game.AirSpeedcap
			{
				Player.Xsp += Player.AirAcc;
				if Player.Xsp >= Player.TopAcc
				{
					Player.Xsp = Player.TopAcc;
				}
			}
			Player.Facing = FlipRight;
		}	
	}
	
	// Apply air drag
	if Player.Ysp < 0 and Player.Ysp > -4 and !Player.Hurt
	{
		Player.Xsp -= floor(Player.Xsp / 0.125) / 256;
	}
	
	// Handle animations
	if Player.Animation = AnimSpring and Player.Ysp > 0
	{
		Player.Animation = AnimWalk;
	}
	if Player.Animation == AnimBreathe and animation_get_frame(id) == 2
	{
		Player.Animation = AnimWalk;
	}
}