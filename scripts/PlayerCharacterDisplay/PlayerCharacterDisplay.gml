function PlayerCharacterDisplay()
{	
	// Set visual angle
	if Game.SmoothRotation 
	{
		if SlopeAngle >= 25.5 and SlopeAngle <= 334.5 or !Grounded or SlopeAngle = 0 
		{
			VisualAngle = Angle;
		} 
		else 
		{
			if VisualAngle > 0 and VisualAngle < 90 
			{
				VisualAngle -= 5.625;
			}
			if VisualAngle > 270 and VisualAngle < 360 
			{
				VisualAngle += 5.625;
			}
			if VisualAngle < 0 or VisualAngle > 360 
			{
				VisualAngle = 0;
			}
		}
	}
	else 
	{
		if (Angle > 334.5 or Angle < 25.5)  VisualAngle =   0;
		if (Angle > 25.5 and Angle < 75)	VisualAngle =  45; 
		if (Angle > 75   and Angle < 105)	VisualAngle =  90; 
		if (Angle > 105  and Angle < 155)   VisualAngle = 135; 
		if (Angle > 155  and Angle < 205)   VisualAngle = 180; 
		if (Angle > 205  and Angle < 255)   VisualAngle = 225; 
		if (Angle > 255  and Angle < 285)   VisualAngle = 270; 
		if (Angle > 285  and Angle < 334.5) VisualAngle = 305;
	}	
	if (Inertia = 0 and Grounded) or Animation = AnimRoll
	{
		VisualAngle = 0
	}
	
	// Update character
	x		     = floor(PosX);
	y			 = floor(PosY);
	image_xscale = Facing;
	image_angle  = VisualAngle;
	depth		 = DrawOrder;
	
	// Draw self
	draw_self();
}