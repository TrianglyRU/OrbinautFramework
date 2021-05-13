function ScreenDebugSensorsDisplay()
{
	// Exit the code if devmode is disabled
	if (!Game.DevMode) exit;
	
	// Activate solidbox debugging
	if Stage.State != ActStateLoading
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
					switch FloorRange
					{
						case RangeFloor:
						{
							draw_point(floor(PosX - xRadius), floor(PosY + yRadius));							
							draw_point(floor(PosX + xRadius), floor(PosY + yRadius));
						
							if Inertia == 0
							{
								draw_point(floor(PosX), floor(PosY + yRadius));
							}
						}
						break;
						case RangeRWall:
						{
							draw_point(floor(PosX + yRadius), floor(PosY + xRadius));
							draw_point(floor(PosX + yRadius), floor(PosY - xRadius));
						}
						break;
						case RangeRoof:
						{
							draw_point(floor(PosX - xRadius), floor(PosY - yRadius));
							draw_point(floor(PosX + xRadius), floor(PosY - yRadius));
						}
						break;
						case RangeLWall:
						{
							draw_point(floor(PosX - yRadius), floor(PosY + xRadius));
							draw_point(floor(PosX - yRadius), floor(PosY - xRadius));
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
						switch WallRange
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
						switch WallRange
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
					draw_point(floor(PosX - xRadius), floor(PosY + yRadius));
					draw_point(floor(PosX + xRadius), floor(PosY + yRadius));
				}
			
				// Display roof sensors
				if Ysp < 0 or abs(Xsp) > abs(Ysp)
				{
					draw_point(floor(PosX - xRadius), floor(PosY - yRadius));
					draw_point(floor(PosX + xRadius), floor(PosY - yRadius));
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
		
		// Display object sensors
		with Objects
		{
		}
		
		// Restore draw colour
		draw_set_colour($ffffff);
	}
}