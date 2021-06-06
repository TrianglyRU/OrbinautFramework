function ObjTailsObjectDisplay()
{
	// If we're not rolling or jumping, use current visual angle
	if Player.Animation != AnimRoll
	{
		ResultAngle = Player.VisualAngle;
	}
		
	// In case we're rolling or jumping
	else
	{
		if !Player.Grounded
		{
			// Get movement angle based on current and next frame position
			if Player.Facing == DirRight
			{
				MotionAngle = point_direction(Player.PosX, Player.PosY, Player.PosX + Player.Xsp, Player.PosY + Player.Ysp);
			}
			else if Player.Facing == DirLeft
			{
				MotionAngle = point_direction(Player.PosX + Player.Xsp, Player.PosY + Player.Ysp, Player.PosX, Player.PosY);
			}
		}
		else
		{																 
			MotionAngle = Player.Angle;
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