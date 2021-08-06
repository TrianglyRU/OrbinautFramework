function ScreenDebugSensorsDisplay()
{
	// Exit the code if devmode is disabled
	if !Game.DevMode
	{
		exit;
	}
	
	// Activate solidbox debugging
	if Stage.State != StageLoad
	{
		if keyboard_check_pressed(ord("R"))
		{
			DebugSensors = !DebugSensors;
		}
	}

	// Check if general and sensor debugging is enabled
	if DebugToggle and DebugSensors
	{
		// Set green draw colour
		draw_set_colour($00ff00);
		
		// Display player sensors
		with Player
		{
			// Check if player is grounded
			if Grounded
			{
				// Display floor sensors (if not on object)
				if !OnObject
				{
					switch AngleQuadFloor
					{
						case RangeFloor:
						{
							draw_point(floor(PosX - RadiusX), floor(PosY + RadiusY));							
							draw_point(floor(PosX + RadiusX), floor(PosY + RadiusY));
						
							if Inertia == 0
							{
								draw_point(floor(PosX), floor(PosY + RadiusY));
							}
						}
						break;
						case RangeRWall:
						{
							draw_point(floor(PosX + RadiusY), floor(PosY + RadiusX));
							draw_point(floor(PosX + RadiusY), floor(PosY - RadiusX));
						}
						break;
						case RangeRoof:
						{
							draw_point(floor(PosX - RadiusX), floor(PosY - RadiusY));
							draw_point(floor(PosX + RadiusX), floor(PosY - RadiusY));
						}
						break;
						case RangeLWall:
						{
							draw_point(floor(PosX - RadiusY), floor(PosY + RadiusX));
							draw_point(floor(PosX - RadiusY), floor(PosY - RadiusX));
						}
						break;
					}
				}
					
				// Display wall sensors
				/* We do not shift them on debug, because player already has moved on this frame, so there is no reason for that */
				if (Angle < 90 or Angle > 270) or (Game.ExtensiveWallCollision and Angle mod 90 == 0)
				{	
					// Display left wall sensor
					if Inertia < 0
					{
						switch AngleQuadWall
						{
							case RangeFloor:
							{
								draw_point(floor(PosX - 10), floor(PosY + 8 * (Angle == 360)));
							}
							break;
							case RangeRWall:
							{
								draw_point(floor(PosX), floor(PosY + 10));
							}
							break;
							case RangeRoof:
							{
								draw_point(floor(PosX + 10), floor(PosY));
							}
							break;
							case RangeLWall:
							{
								draw_point(floor(PosX), floor(PosY - 10));
							}
							break;
						}
					}
				
					// Display right wall sensor
					else if Inertia > 0
					{
						switch AngleQuadWall
						{
							case RangeFloor:
							{
								draw_point(floor(PosX + 10), floor(PosY + 8 * (Angle == 360)));
							}
							break;
							case RangeRWall:
							{
								draw_point(floor(PosX), floor(PosY - 10));
							}
							break;
							case RangeRoof:
							{
								draw_point(floor(PosX - 10), floor(PosY));
							}
							break;
							case RangeLWall:
							{
								draw_point(floor(PosX), floor(PosY + 10));
							}
							break;
						}
					}
				}
			}
		
			// Check if player is airborne
			else
			{
				// Display floor sensors
				if Ysp > 0 or abs(Xsp) > abs(Ysp)
				{
					draw_point(floor(PosX - RadiusX), floor(PosY + RadiusY));
					draw_point(floor(PosX + RadiusX), floor(PosY + RadiusY));
				}
			
				// Display roof sensors
				if Ysp < 0 or abs(Xsp) > abs(Ysp)
				{
					draw_point(floor(PosX - RadiusX), floor(PosY - RadiusY));
					draw_point(floor(PosX + RadiusX), floor(PosY - RadiusY));
				}
			
				// Display wall sensors
				if !(Xsp > abs(Ysp))
				{
					draw_point(floor(PosX - 10), floor(PosY));
				}
				if !(-Xsp > abs(Ysp))
				{
					draw_point(floor(PosX + 10), floor(PosY));
				}
			}
		}

		// Restore draw colour
		draw_set_colour($ffffff);
	}
}