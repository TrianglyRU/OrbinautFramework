function PlayerKnuxGlide()
{
	// Exit the code if we're not gliding
	if !Player.GlideState
	{
		exit;
	}
	
	// Air glide
	if Player.GlideState == GlideActive and !Player.GlideGrounded
	{
		// Check if button is held
		if Input.ABC
		{
			Player.Animation = AnimGlide;
			Player.Grv	     = Player.Ysp < 0.5 ? 0.125 : -0.125;
			
			// Gliding to the left
			if Player.GlideDirection = FlipLeft
			{	
				if Player.GlideValue > 0
				{
					Player.GlideValue -= 2.8125;		
					Player.Xsp		   = Player.GlideSpeed * dcos(Player.GlideValue) * -sign(Player.GlideSpeed);
				}
				else
				{
					Player.Xsp = max(Player.Xsp - Player.GlideAcc, -24);
				}
				
				// Start turn
				if Input.RightPress
				{
					if Player.GlideValue == 0
					{
						Player.GlideSpeed = Player.Xsp;
					}
					Player.GlideDirection = FlipRight;
				}
			}
		
			// Gliding to the right
			else if Player.GlideDirection == FlipRight
			{	
				if Player.GlideValue < 180
				{
					Player.GlideValue += 2.8125;
					Player.Xsp		   = Player.GlideSpeed * dcos(Player.GlideValue) * -sign(Player.GlideSpeed);
				}
				else
				{
					Player.Xsp = min(Player.Xsp + Player.GlideAcc, 24);
				}
				
				// Start turn
				if Input.LeftPress
				{	
					if Player.GlideValue == 180
					{
						Player.GlideSpeed = Player.Xsp;
					}
					Player.GlideDirection = FlipLeft;
				}
			}
		
			// Define facing direction
			Player.Facing = Player.GlideValue > 90 ? FlipRight : FlipLeft;
		
			// Define animation frame
			if Player.GlideValue < 120
			{
				if Player.GlideValue > 60
				{
					Player.GlideFrame = 3;
				}
				else if Player.GlideValue > 30
				{
					Player.GlideFrame = 2;
				}
				else
				{
					Player.GlideFrame = 1;
				}
			}
			else if Player.GlideValue < 150
			{
				Player.GlideFrame = 2;
			}		
			else
			{
				Player.GlideFrame = 1;
			}
		}
	
		// If button is not held anymore
		else
		{
			Player.Xsp       *= 0.25;
			Player.GlideState = GlideDrop;
			Player.Animation  = AnimGlideDrop;
			Player.RadiusX	  = Player.DefaultRadiusX;
			Player.RadiusY	  = Player.DefaultRadiusY;
		
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
	}
	
	// Check for walls
	var LeftDistance  = tile_check_collision_h(floor(Player.PosX - 10), floor(Player.PosY), false, true, Player.Layer)[0];
	var RightDistance = tile_check_collision_h(floor(Player.PosX + 10), floor(Player.PosY), true,  true, Player.Layer)[0];
			
	// Are we colliding with the wall?
	if LeftDistance < 0 or RightDistance < 0
	{
		if LeftDistance < 0
		{
			Player.PosX -= LeftDistance;
		}
		else if RightDistance < 0
		{
			Player.PosX += RightDistance;
		}
		Player.Xsp = 0;
		
		// If gliding, start climbing
		if Player.GlideState == GlideActive and !Player.GlideGrounded
		{
			Player.Ysp		  = 0;
			Player.GlideState = false;
			Player.ClimbState = true;
			Player.RadiusY    = Player.DefaultRadiusY;
			
			audio_sfx_play(sfxGrab, false);
		}	
	}
			
	// If we're not colliding walls, try floor or ceiling collision
	else
	{
		// Check for ceiling
		var TileLeft    = tile_check_collision_v(floor(Player.PosX - Player.RadiusX), floor(Player.PosY - Player.RadiusY), false, true, Player.Layer);
		var TileRight   = tile_check_collision_v(floor(Player.PosX + Player.RadiusX), floor(Player.PosY - Player.RadiusY), false, true, Player.Layer);
		var NearestTile = tile_check_nearest(TileLeft, TileRight, noone);
				
		// Get data
		var RoofDistance = NearestTile[0];
		var RoofAngle    = NearestTile[1];
			
		// Clip out if touching the ceiling
		if RoofDistance < 0
		{	
			if Player.Ysp < 0
			{
				Player.Ysp = 0;
			}
			Player.PosY -= RoofDistance;
		}
				
		// If we're not touching the ceiling, try floor collision
		else if Player.Ysp >= 0
		{
			// Check for floor
			var TileLeft    = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY + RadiusY), true, false, Layer);
			var TileRight   = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY + RadiusY), true, false, Layer);
			var NearestTile = tile_check_nearest(TileLeft, TileRight, noone);
					
			// Get data
			var FloorDistance = NearestTile[0];
			var FloorAngle    = NearestTile[1];
			
			// Are we gliding in the air?
			if !Player.GlideGrounded
			{	
				// Are we not in stop state?
				if Player.GlideState != GlideStop
				{
					if FloorDistance < 0
					{
						Player.Ysp = 0;
						Player.Grv = 0;
				
						// Is floor shallow enough?
						if FloorAngle <= 45 or FloorAngle >= 315
						{
							// Enter slide state if gliding
							if Player.GlideState == GlideActive
							{
								Player.GlideValue    = 0;
								Player.GlideGrounded = true;
								
								// Create dust effect
								instance_create(floor(Player.PosX), floor(Player.PosY + Player.RadiusY), DustPuff);
							}
							
							// Enter stop state if dropping
							else if Player.GlideState == GlideDrop
							{
								Player.PosY		 += FloorDistance;
								Player.GlideState = GlideStop;
								Player.GlideValue = 16;
								Player.Xsp	      = 0;
								
								audio_sfx_play(sfxLand, false);
							}
						}
				
						// If floor is steep, just land
						else
						{	
							Player.Angle    = FloorAngle;
							Player.Inertia  = FloorAngle < 180 ? -Player.Ysp : Player.Ysp;
							Player.Xsp		= 0;
							Player.Grounded = true;
						}
					}
				}
		
				// If in stop state, land
				if Player.GlideState == GlideStop
				{
					if !(--Player.GlideValue)
					{
						Player.Angle    = FloorAngle;
						Player.Grounded = true;
					}
					Player.Animation = AnimDropStand;
				}
			}
	
			// Are we sliding?
			if Player.GlideGrounded
			{
				Player.Animation = AnimGlideGrounded;
		
				// Decelerate
				if Player.Xsp > 0
				{
					Player.Xsp = max(0, Player.Xsp - Player.AirAcc);
				}
				else
				{
					Player.Xsp = min(0, Player.Xsp + Player.AirAcc);
				}
		
				// Enter drop state if floor is far away from us
				if FloorDistance > 14
				{
					// Reset gravity
					if !Player.IsUnderwater
					{
						Player.Grv = 0.21875;
					}
					else
					{
						// Lower by 0x28 (0.15625) if underwater
						Player.Grv = 0.0625
					}
					
					Player.GlideGrounded = false;
					Player.Animation     = AnimGlideDrop;
					Player.GlideState    = GlideDrop;
					Player.RadiusX		 = Player.DefaultRadiusX;
					Player.RadiusY	     = Player.DefaultRadiusY;
				}
				else
				{	
					// Enter stop state
					if Player.Xsp == 0 or !Input.ABC
					{
						if Player.GlideState != GlideStop
						{
							Player.GlideValue = 16;
							Player.GlideState = GlideStop;
						}
						if !(--Player.GlideValue)
						{
							Player.Angle    = FloorAngle;
							Player.Grounded = true;
						}
						else
						{
							// Check for jump
							if Input.ABCPress
							{	
								// Do not jump if there is ceiling above us
								if tile_check_collision_v(floor(Player.PosX - Player.RadiusX), floor(Player.PosY - Player.RadiusY), false, true, Player.Layer)[0] < 6
								or tile_check_collision_v(floor(Player.PosX + Player.RadiusX), floor(Player.PosY - Player.RadiusY), false, true, Player.Layer)[0] < 6
								{
									exit;
								}
					
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
								
								Player.Jumping    = true;
								Player.Grounded   = false;
								Player.GlideState = false;
								Player.Xsp		 += Player.Jump * dsin(Player.Angle);
								Player.Ysp       += Player.Jump * dcos(Player.Angle);
								Player.PosY      -= Player.SmallRadiusY - Player.RadiusY;
								Player.RadiusY    = Player.SmallRadiusY;
								Player.RadiusX	  = Player.SmallRadiusX;
								Player.Animation  = AnimRoll
									
								// Play sound
								audio_sfx_play(sfxJump, false);
							}
							else
							{
								Player.PosY     -= Player.DefaultRadiusY - Player.RadiusY;
								Player.RadiusX   = Player.DefaultRadiusX;
								Player.RadiusY   = Player.DefaultRadiusY;
								Player.Animation = AnimGlideStand;
								Player.Xsp		 = 0;
							}
						}
					}
					
					// Slide
					else 
					{
						if (++Player.GlideValue) mod 8 == 0
						{
							audio_sfx_play(sfxSlide, false);
						}
						Player.PosY += FloorDistance;
					}
				}
			}
		}
	}
}