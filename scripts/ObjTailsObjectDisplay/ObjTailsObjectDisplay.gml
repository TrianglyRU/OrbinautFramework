function ObjTailsObjectDisplay()
{
	// If we're not rolling or jumping, use current visual angle
	if Player.Animation != AnimRoll
	{
		ResultAngle = Player.VisualAngle;
		MotionAngle = Player.VisualAngle;
	}
		
	// In case we're rolling or jumping
	else
	{
		if !Player.Grounded
		{
			// Get movement angle based on current and next frame position
			if Player.Facing == DirectionRight
			{
				MotionAngle = point_direction(Player.PosX, Player.PosY, Player.PosX + Player.Xsp, Player.PosY + Player.Ysp);
			}
			else if Player.Facing == DirectionLeft
			{
				MotionAngle = point_direction(Player.PosX + Player.Xsp, Player.PosY + Player.Ysp, Player.PosX, Player.PosY);
			}
		}
		else
		{	
			/* Rotation step code by Nihil (NullSpace)
			Used with permission! */	
					   
			// Interpolate angle
			if Player.Angle >= 23.91 and Player.Angle <= 337.5
			{
				var TargetAngle  = Player.Angle;
				var RotationStep = (abs(Player.Inertia) / 16 + abs(Player.Inertia) / 32 - 2) * -1
			}
			else
			{
				var TargetAngle  = 360;
				var RotationStep = (abs(Player.Inertia) / 16 - 2) * -1
			}
					
			// Perform angle calculation
			MotionAngle = darctan2(dsin(TargetAngle) + dsin(MotionAngle) * RotationStep, dcos(TargetAngle) + dcos(MotionAngle) * RotationStep);
		}
			
		// If smooth rotation is enabled, use raw movement angle for tails visual angle
		if Game.SmoothRotation
		{
			ResultAngle = MotionAngle;
		}
			
		// If smooth rotation is disabled, use this table for tails visual angle
		else
		{
			if (MotionAngle > 334.5 or MotionAngle < 25.5)  ResultAngle = 360;
			if (MotionAngle > 25.5 and MotionAngle < 75)	ResultAngle = 45; 
			if (MotionAngle > 75   and MotionAngle < 105)	ResultAngle = 90; 
			if (MotionAngle > 105  and MotionAngle < 155)   ResultAngle = 135; 
			if (MotionAngle > 155  and MotionAngle < 205)   ResultAngle = 180; 
			if (MotionAngle > 205  and MotionAngle < 255)   ResultAngle = 225; 
			if (MotionAngle > 255  and MotionAngle < 285)   ResultAngle = 270; 
			if (MotionAngle > 285  and MotionAngle < 334.5) ResultAngle = 305;
		}
			
	}
		
	// Update tails display information
	x			 = floor(Player.PosX);
	y			 = floor(Player.PosY);	
	depth		 = Player.DrawOrder + 1;
	image_xscale = Player.Facing;
	image_angle  = ResultAngle;

	// Draw tails on the screen
	draw_self();
}