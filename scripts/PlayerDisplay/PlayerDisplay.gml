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
					if Angle >= 23.91 and Angle <= 337.5
					{
						// Start rotate on the right side
						var StartRotationRight = min(VisualAngle mod 360 + 5.625, Angle + Xsp)
																							 
						// Rotation on the right side
						var RotationRight = min(VisualAngle mod 360 + Inertia, Angle + Xsp);
						
						// Start rotate on the left side
						var StartRotationLeft = max(Angle + Xsp, VisualAngle - 5.625);
						
						// Rotation on the left side
						var RotationLeft = max(Angle + Xsp, VisualAngle + Inertia);
						
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
				else if VisualAngle != 360
				{
					VisualAngle = Angle;		
				}
				
				// Limit visual angle
				VisualAngle = clamp(VisualAngle, 0, 360);
			}
	
			// If smooth rotation is disabled, use this table for visual angle
			else 
			{	
				if (Angle >= 338.91 or  Angle <= 22.5)  VisualAngle = 360;
				if (Angle >= 23.91  and Angle <= 67.5)  VisualAngle = 45; 
				if (Angle >= 68.91  and Angle <= 112.5) VisualAngle = 90; 
				if (Angle >= 113.91 and Angle <= 157.5) VisualAngle = 135; 
				if (Angle >= 158.91 and Angle <= 202.5) VisualAngle = 180; 
				if (Angle >= 203.91 and Angle <= 247.5) VisualAngle = 225; 
				if (Angle >= 248.91 and Angle <= 292.5) VisualAngle = 270; 
				if (Angle >= 293.91 and Angle <= 337.5) VisualAngle = 305;
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
	if IsInvincible
	{
		if IsInvincible mod 4 == 0
		{
			image_alpha = !image_alpha;
		}
	}
	else
	{
		image_alpha = 1;
	}
	
	// Update character display
	x			 = floor(PosX) + (Facing == DirectionLeft);
	y		     = floor(PosY);
	depth		 = DrawOrder;
	image_xscale = Facing;
	image_angle  = VisualAngle;
	
	// Draw player on the screen
	draw_self();
}