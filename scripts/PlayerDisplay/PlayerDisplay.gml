function PlayerDisplay()
{	
	// Use visual angle only for some animations, 
	switch Animation
	{
		case AnimWalk:
		case AnimRun:
		case AnimPeelout:
		{
			// Check if smooth rotation is enabled
			if Game.SmoothRotation
			{
				// Check if we grounded
				if Grounded
				{
					// If in correct floor angle range, apply it to visual angle
					if Angle >= 25.5 and Angle <= 334.5
					{
						// Start rotate on the right side
						var StartRotationRight = min(VisualAngle mod 360 + 5.625, Angle)
																							 
						// Rotation on the right side
						var RotationRight = min(VisualAngle mod 360 + Inertia, Angle);
						
						// Start rotate on the left side
						var StartRotationLeft = max(Angle, VisualAngle - 5.625);
						
						// Rotation on the left side
						var RotationLeft = max(Angle, VisualAngle + Inertia);
						
						// Do rotation
						VisualAngle = Angle <= 180 ? clamp(max(StartRotationRight, RotationRight), 0,   180)
												   : clamp(min(StartRotationLeft,  RotationLeft),  180, 360);
					}
			
					// Rotate visual angle back to 360 if out of the range
					else 
					{
						VisualAngle = VisualAngle > 180 ? VisualAngle + 5.625 : VisualAngle - 5.625;
					}
				}
		
				// Simply apply regular angle to visual angle while in-air
				else
				{
					VisualAngle = Angle;
					
				}
				
				// Limit visual angle
				VisualAngle = clamp(VisualAngle, 0, 360);
			}
	
			// If smooth rotation is disabled, use this table for visual angle
			else 
			{	
				if (Angle > 334.5 or Angle < 25.5)  VisualAngle = 360;
				if (Angle > 25.5 and Angle < 75)	VisualAngle =  45; 
				if (Angle > 75   and Angle < 105)	VisualAngle =  90; 
				if (Angle > 105  and Angle < 155)   VisualAngle = 135; 
				if (Angle > 155  and Angle < 205)   VisualAngle = 180; 
				if (Angle > 205  and Angle < 255)   VisualAngle = 225; 
				if (Angle > 255  and Angle < 285)   VisualAngle = 270; 
				if (Angle > 285  and Angle < 334.5) VisualAngle = 305;
			}
		}
		break;
		default:
		{
			VisualAngle = 360;
		}
		break;
	}
	
	// Blink sprite
	if isInvincible and (isInvincible mod 4 == 0)
	{
		image_alpha = !image_alpha;
	}
	
	// Update character display
	x			 = floor(PosX) + (Facing == DirLeft);
	y		     = floor(PosY);
	depth		 = DrawOrder;
	image_xscale = Facing;
	image_angle  = VisualAngle;
	
	// Draw player on the screen
	draw_self();
}