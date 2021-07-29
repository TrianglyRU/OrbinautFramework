function _rotationOld()
{
	// Get rotation start/end speed
	var RotationSpeed = max(5.625, abs(Inertia));
					
	// If in correct floor angle range, apply it to visual angle
	if Angle >= 23.91 and Angle <= 337.5
	{
		// Start rotation on the right side
		var StartRotationRight = min(VisualAngle mod 360 + RotationSpeed, Angle)
																							 
		// Rotation on the right side
		var RotationRight = min(VisualAngle mod 360 + Inertia, min(Angle + 5.625 + abs(Inertia), 180));
						
		// Start rotation on the left side
		var StartRotationLeft = max(VisualAngle - RotationSpeed, Angle);
						
		// Rotation on the left side
		var RotationLeft = max(VisualAngle + Inertia, max(Angle - 5.625 - abs(Inertia), 180));
						
		// Do rotation
		VisualAngle = Angle < 180 ? max(StartRotationRight, RotationRight) : min(StartRotationLeft, RotationLeft);
	}
			
	// Rotate visual angle back to 360 if out of the range
	else 
	{
		VisualAngle += VisualAngle > 180 ? RotationSpeed : -RotationSpeed;
	}
					
	// Limit visual angle
	VisualAngle = clamp(VisualAngle, 0, 360);
}