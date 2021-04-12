function PlayerCharacterDisplay()
{	
	// Update visual angle
	if Game.SmoothRotation
	{
		if Angle >= 25.5 and Angle <= 334.5 or !Grounded or Angle == 360
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
				VisualAngle = 360;
			}
		}
	}
	else 
	{
		if (Angle > 334.5 or Angle < 25.5)  VisualAngle = 360;
		if (Angle > 25.5 and Angle < 75)	VisualAngle =  45; 
		if (Angle > 75   and Angle < 105)	VisualAngle =  90; 
		if (Angle > 105  and Angle < 155)   VisualAngle = 135; 
		if (Angle > 155  and Angle < 205)   VisualAngle = 180; 
		if (Angle > 205  and Angle < 255)   VisualAngle = 225; 
		if (Angle > 255  and Angle < 285)   VisualAngle = 270; 
		if (Angle > 285  and Angle < 334.5) VisualAngle = 305;
	}
	
	// Force visual angle to be 0
	if Inertia == 0 and Grounded
	or Animation == AnimRoll or Animation == AnimFly or Animation == AnimGlide or Animation == AnimSkid or Animation == AnimClimb
	{
		VisualAngle = 360;
	}
	
	// Update character render
	x			 = floor(PosX);
	y		     = floor(PosY);
	depth		 = DrawOrder;
	image_xscale = Facing;
	image_angle  = VisualAngle;
	
	// Draw player
	draw_self();

	// Update Tails' tails render
	if CharacterID == CharTails
	{
		// Update tails visual angle
		if Animation != AnimRoll
		{
			var TailsAngle = VisualAngle;
		}
		else
		{
			if Facing == DirRight
			{
				var DirectionAngle = point_direction(PosX, PosY, PosX + Xsp, PosY + Ysp);
			}
			else if Facing == DirLeft
			{
				var DirectionAngle = point_direction(PosX + Xsp, PosY + Ysp, PosX, PosY);
			}
			
			if Game.SmoothRotation
			{
				var TailsAngle = DirectionAngle;
			}
			else
			{
				if (DirectionAngle > 334.5 or DirectionAngle < 25.5)  var TailsAngle = 360;
				if (DirectionAngle > 25.5 and DirectionAngle < 75)	  var TailsAngle =  45; 
				if (DirectionAngle > 75   and DirectionAngle < 105)	  var TailsAngle =  90; 
				if (DirectionAngle > 105  and DirectionAngle < 155)   var TailsAngle = 135; 
				if (DirectionAngle > 155  and DirectionAngle < 205)   var TailsAngle = 180; 
				if (DirectionAngle > 205  and DirectionAngle < 255)   var TailsAngle = 225; 
				if (DirectionAngle > 255  and DirectionAngle < 285)   var TailsAngle = 270; 
				if (DirectionAngle > 285  and DirectionAngle < 334.5) var TailsAngle = 305;
			}
			
		}
		
		// Update tails render
		TailsObject.x			 = x;
		TailsObject.y			 = y;	
		TailsObject.depth		 = DrawOrder + 5;
		TailsObject.image_xscale = Facing;
		TailsObject.image_angle  = TailsAngle;

		// Draw tails
		with TailsObject draw_self();
	}
}