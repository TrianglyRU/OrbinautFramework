/// @description Main Script
// You can write your code in this editor

	// Variable declaration
    var CurrentSegment, PlayerPosition, Tension, i, log_difference;
	
	// Get a log number player is standing on
	PlayerPosition = (Player.PosX - x + 16) div 16;
	CurrentSegment = clamp(PlayerPosition, 1, SegmentAmount);
	
	// Set a recovery angle
	if PlayerPosition > 0 and PlayerPosition < SegmentAmount + 1 and Player.Grounded
	{	
		if (RecoveryAngle < 64) RecoveryAngle += 4;
	} 
	else if RecoveryAngle > 0
	{
		RecoveryAngle -= 4;
	}
	
	// Bridge physics
	for (i = 0; i < SegmentAmount; i++)
	{	
		if i < CurrentSegment 
		{	
			// Set tension to the left
			Tension = (64 * (i + 1)) / (CurrentSegment);		
		}
		else 
		{	
			// Set tension to the right
			Tension = (64 * (SegmentAmount - i)) / (SegmentAmount - CurrentSegment + 1);
		}
		
		// Reposite logs
		LogY[i] = y + 8 + dsin(Tension * RecoveryAngle / 64) * Deflection[CurrentSegment - 1];
		
		/*// Check for current log
		log_difference = abs((i + 1) - CurrentSegment);
		
		// Set tension to the left
		if i < CurrentSegment
		{
			Tension = log_difference / CurrentSegment;
		}
		
		// Set tension to the right
		else
		{
			Tension = log_difference / (SegmentAmount - CurrentSegment + 1);
		}
		
		// Reposite logs
		LogY[i] = floor(y + 8 + Deflection[CurrentSegment - 1] * dsin(floor(90 * (1 - Tension))) * dsin(RecoveryAngle));*/
	}
	
	