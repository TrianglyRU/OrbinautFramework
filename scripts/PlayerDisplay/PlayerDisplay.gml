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
					/* Rotation step code by Nihil (NullSpace)
					   Used with permission! */	
					   
					// Interpolate angle
					if Angle >= 23.91 and Angle <= 337.5
					{
						var TargetAngle  = Angle;
						var RotationStep = (abs(Inertia) / 16 + abs(Inertia) / 32 - 2) * -1
					}
					else
					{
						var TargetAngle  = 360;
						var RotationStep = (abs(Inertia) / 16 - 2) * -1
					}
					
					// Perform angle calculation
					VisualAngle = darctan2(dsin(TargetAngle) + dsin(VisualAngle) * RotationStep, dcos(TargetAngle) + dcos(VisualAngle) * RotationStep);
				}
		
				// Simply apply regular angle to visual angle while in-air
				else if VisualAngle != 360
				{
					VisualAngle = Angle;		
				}
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
	if InvincibilityFrames
	{
		if !(InvincibilityFrames mod 4)
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