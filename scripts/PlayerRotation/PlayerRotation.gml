function PlayerRotation()
{
	// Force visual angle of 360 degrees for all animations but AnimMove
	if Animation != AnimMove
	{
		VisualAngle = 360;
	}
	else
	{
		// Apply smooth rotation
		if Game.SmoothRotation
		{
			if Grounded
			{
				/* Smooth rotation code by Nihil (NullSpace)
				Used with permission! */	
					   
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
				VisualAngle = darctan2(dsin(TargetAngle) + dsin(VisualAngle) * RotationStep, dcos(TargetAngle) + dcos(VisualAngle) * RotationStep);	
			}
			else
			{
				// Keep visual angle positive
				if VisualAngle <= 0
				{
					VisualAngle += 360;
				}
				
				// Rotate back to 0/360
				if VisualAngle < 180
				{
					VisualAngle = max(VisualAngle - 2.8125, 0);
				}
				else
				{
					VisualAngle = min(VisualAngle + 2.8125, 360);
				}	
			}
		}
	
		// Apply regular rotation
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
}