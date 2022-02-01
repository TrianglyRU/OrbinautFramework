function PlayerRotation()
{
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
				
				// We use Mania angle range for smooth rotation
				if Angle > 33.75 and Angle < 326.25
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
				// Rotate back to 360
				if VisualAngle <= 0
				{
					VisualAngle += 360;
				}
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
	
		// Apply regular classic-like rotation
		else if Angle > 22.5 and Angle < 338.91
		{	
			VisualAngle = ceil((Angle - 22.5) / 45) * 45;
		}
		else
		{
			VisualAngle = 360;
		}
	}
}