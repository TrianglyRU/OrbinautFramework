function PlayerDisplay()
{	
	// Check if smooth rotation is enabled
	if Game.SmoothRotation
	{
		// Check if we grounded
		if Grounded
		{
			// If in correct floor angle range, apply it to visual angle
			if Angle >= 25.5 and Angle <= 334.5
			{
				VisualAngle = Angle <= 180 ? min(VisualAngle mod 360 + 5.625, Angle) 
										   : max(VisualAngle - 5.625, Angle);
			}
			
			// Rotate visual angle back to 360 if out of the range
			else 
			{
				VisualAngle = VisualAngle > 180 ? VisualAngle + 5.625 : VisualAngle - 5.625;
			}
			
			// Limit visual angle
			VisualAngle = clamp(VisualAngle, 0, 360);
		}
		
		// Simply apply regular angle to visual angle while in-air
		else
		{
			VisualAngle = Angle;
		}
	}
	
	// If smooth rotation is disabled, use this table for visual angle
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
	
	// Force reset visual angle for specific animations
	if Grounded and Inertia == 0 and (Angle < 45 or Angle > 315)
	or ClimbingState != false
	or GlidingState  != false 
	or FlyingState   != false 
	or Skidding      != false 
	or Rolling 
	or Jumping
	or Hurt
	or Death
	{
		VisualAngle = 360;
	}
	
	// Handle Tails' tails if we're playing as him
	if CharacterID == CharTails
	{
		// If we're not rolling or jumping, use current visual angle
		if Animation != AnimRoll
		{
			var TailsAngle = VisualAngle;
		}
		
		// In case we're rolling or jumping
		else
		{
			// Get movement angle based on current and next frame position
			if Facing == DirRight
			{
				var DirectionAngle = point_direction(PosX, PosY, PosX + Xsp, PosY + Ysp);
			}
			else if Facing == DirLeft
			{
				var DirectionAngle = point_direction(PosX + Xsp, PosY + Ysp, PosX, PosY);
			}
			
			// If smooth rotation is enabled, use raw movement angle for tails visual angle
			if Game.SmoothRotation
			{
				var TailsAngle = DirectionAngle;
			}
			
			// If smooth rotation is disabled, use this table for tails visual angle
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
		
		// Update tails display information
		TailsObject.x			 = floor(PosX);
		TailsObject.y			 = floor(PosY);	
		TailsObject.depth		 = DrawOrder;
		TailsObject.image_xscale = Facing;
		TailsObject.image_angle  = TailsAngle;

		// Draw tails on the screen
		with TailsObject draw_self();
	}
	
	// Blink sprite
	if isInvincible and (isInvincible mod 4 == 0)
	{
		visible = !visible;
	}
	
	// Update character display information
	x			 = floor(PosX);
	y		     = floor(PosY);
	depth		 = DrawOrder;
	image_xscale = Facing;
	image_angle  = VisualAngle;
	
	// Draw player on the screen
	draw_self();
}