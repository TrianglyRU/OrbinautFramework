function PlayerKnuxClimb()
{
	// Exit if we're not climbing
	if !Player.ClimbState
	{
		exit;
	}
	
	/* Knuckles climb code completely overrides air collision code,
	so AirLevelCollision is not performed */
	   
	// Set animation
	Player.Animation = AnimClimb;
	
	// Climb on walls
	if Player.ClimbState == 1
	{
		// Move up and down and all around
		if Input.Up
		{
			Player.Ysp = -Player.ClimbSpeed;
		}
		else if Input.Down
		{
			Player.Ysp = Player.ClimbSpeed;
		}
		else
		{
			Player.Ysp = 0;
		}
		
		// Check for ceiling if moving upwards
		if Player.Ysp < 0
		{
			var RoofDistance = tile_check_collision_v(floor(Player.PosX + Player.RadiusX * Player.Facing), floor(Player.PosY - Player.RadiusY), false, true, Player.Layer)[0];	
			if  RoofDistance < 0
			{	
				Player.PosY -= RoofDistance;
				Player.Ysp   = 0;
				
				/* Originals seems not to reset Ysp, resulting in Knuckles
				behaving weird when approaching ceilings */
			}
		}
	
		// Check for floor if moving downwards
		else
		{
			var FloorDistance = tile_check_collision_v(floor(Player.PosX + 10 * Player.Facing), floor(Player.PosY + Player.RadiusY), true, false, Player.Layer)[0];	
			if  FloorDistance < 0
			{	
				Player.PosY    += FloorDistance;
				Player.Ysp		= 0;
				Player.Grounded = true;
				Player.RadiusX  = Player.DefaultRadiusX;
				Player.RadiusY  = Player.DefaultRadiusY;
				
				exit;
			}
		}
		
		// Check for collision with walls
		var DistanceAbove = tile_check_collision_h(floor(Player.PosX + Player.RadiusX * Player.Facing), floor(Player.PosY - 10), Player.Facing, true, Player.Layer)[0];
		var DistanceBelow = tile_check_collision_h(floor(Player.PosX + Player.RadiusX * Player.Facing), floor(Player.PosY + 10), Player.Facing, true, Player.Layer)[0];
		
		// Check if we do not find the wall in front of us
		if DistanceBelow > 0
		{
			Player.ClimbState = false;
			Player.GlideState = GlideDrop;
			Player.Animation  = AnimGlideDrop;
			Player.RadiusX    = Player.DefaultRadiusX;
			Player.RadiusY    = Player.DefaultRadiusY;
			
			// Reset gravity
			if !Player.IsUnderwater
			{
				Player.Grv	= 0.21875;
			}
			else
			{
				// Lower by 0x28 (0.15625) if underwater
				Player.Grv = 0.0625
			}	
		}
		
		// Check if we're near the edge to climb on it
		else if DistanceAbove > 0
		{
			Player.ClimbState     = 2;
			Player.Ysp			  = 0;
			Player.AllowCollision = false;
		}
				
		// Check for jump
		else if Input.ABCPress
		{
			Player.Ysp		  = -4;
			Player.Xsp		  = -4 * Player.Facing;
			Player.Facing	 *= -1;
			Player.ClimbState = false;
			Player.Jumping	  = true;
			Player.Animation  = AnimRoll;
			
			// Reset gravity
			if !Player.IsUnderwater
			{
				Player.Grv	= 0.21875;
			}
			else
			{
				// Lower by 0x28 (0.15625) if underwater
				Player.Grv = 0.0625
			}
			
			// Play sound
			audio_sfx_play(sfxJump, false);
		}
	}
		
	// Check if we're climbering on the edge
	if Player.ClimbState == 2
	{	
		switch ++Player.ClimbValue
		{
			case 7:
			{
				Player.PosX += 3 * Player.Facing;
				Player.PosY -= 2;
			}
			break;
			case 13:
			{
				Player.PosX += 8 * Player.Facing;
				Player.PosY -= 10;
			}
			break;
			case 19:
			{
				Player.PosX -= 8 * Player.Facing;
				Player.PosY -= 12;
			}
			break;
			case 25:
			{		
				Player.PosX += 8 * Player.Facing;
				Player.PosY -= Player.DefaultRadiusY - Player.RadiusY;
				
				Player.AllowCollision = true;
				Player.Grounded	      = true;
			}
			break;
		}
		
		Player.Ysp		 = 0;
		Player.Animation = AnimClimbering;
	}
}