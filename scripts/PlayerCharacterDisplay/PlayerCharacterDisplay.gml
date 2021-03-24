function PlayerCharacterDisplay()
{	
	// Update visual angle
	if Game.SmoothRotation 
	{
		if Angle >= 25.5 and Angle <= 334.5 or !Grounded or Angle = 0 
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
	if (Inertia = 0 and Grounded) or Animation = AnimRoll or Animation = AnimFly or Animation = AnimGlide
	{
		VisualAngle = 0
	}
	
	// Perform super palette cycle
	if isSuper
	{
		switch CharacterID
		{
			case CharSonic:
			{
				for (var i = 0; i < 4; i++) 
				{
					palette_cycle_perform(i, 9, 4);
					palette_cycle_perform(i, 9, 4);
					palette_cycle_perform(i, 9, 4);
					palette_cycle_perform(i, 9, 4);
				}
			}
			break;
			case CharTails:
			{
				for (var i = 0; i < 4; i++) 
				{
					palette_cycle_perform(i, 9, 4);
					palette_cycle_perform(i, 9, 4);
					palette_cycle_perform(i, 9, 4);
					palette_cycle_perform(i, 9, 4);
				}
			}
			break;
		}
	}	
	
	// Update character render
	x			 = floor(PosX);
	y		     = floor(PosY);
	depth		 = DrawOrder;
	image_xscale = Facing;
	image_angle  = VisualAngle;
	
	// Update Tails' tails render
	if CharacterID = CharTails
	{
		TailsObject.x			 = floor(PosX);
		TailsObject.y			 = floor(PosY);	
		TailsObject.depth		 = DrawOrder + 1;
		TailsObject.image_xscale = Facing;
		
		if Animation != AnimRoll
		{
			TailsObject.image_angle = VisualAngle;
		}
		else
		{
			if Facing = 1
			{
				TailsObject.image_angle = point_direction(PosX, PosY, PosX + Xsp, PosY + Ysp);
			}
			else
			{
				TailsObject.image_angle = point_direction(PosX + Xsp, PosY + Ysp, PosX, PosY);
			}
		}
	}
}