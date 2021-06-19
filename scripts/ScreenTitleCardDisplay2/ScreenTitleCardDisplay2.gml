function ScreenTitleCardDisplay2()
{
	// Exit the code if CardState is 2
	if CardState == 2
	{
		exit;
	}
	
	// Use title card font
	string_set_font(Game.Font[FontCard], "right");
	
	// Draw card elements
	draw_sprite(spr_hud_line,      0, LineX,	 LineY);
	draw_sprite(spr_hud_ribbon,	   0, RibbonX,	 RibbonY);
	draw_sprite(spr_hud_zoneline,  0, ZonelineX, ZonelineY);
	draw_sprite(spr_hud_act,       0, ActX,		 ActY);
	
	// Draw zone name
	string_display(ZoneX, ZoneY, Stage.ZoneName, 1);
	
	// Start gameplay early if we're loading from previous act
	if CardTimer == 0
	{
		if Game.StageTransitionData[4] == true
		{
			fade_perform(from, black, 0);
			
			Stage.State       = ActStateDefault;
			Stage.TimeEnabled = true;
			Input.IgnoreInput = false;
			InterfaceEnabled  = true;
			CameraEnabled     = true;
		}
	}
	
	// Count card
	CardTimer++;

	if CardState == 0
	{
		// Update ribbon speed
		RibbonXSpeed = max(RibbonXSpeed - 0.05, 0.15);
	
		// Update ribbon position
		RibbonX += RibbonXSpeed;
		RibbonY += 2;
		
		// Loop ribbon vertically
		if RibbonY == 32
		{
			RibbonY -= 32;	
		}
		
		// Update line speed
		if LineX > Width
		{
			LineXSpeed = 0;
		}
		LineAngle += 2;
		LineYSpeed = dsin(LineAngle) / 10;
	
		// Update line position
		LineX += LineXSpeed;
		LineY += LineYSpeed;
	
		// Continue after 30 frames
		if CardTimer < 30 
		{
			exit;
		}
		
		// Update Zoneline position
		if ZonelineX > 60
		{
			ZonelineX = max(60, ZonelineX - 32);
		}
		else
		{
			ZonelineX -= 0.2;
		}
		ZonelineY -= 0.05;
		
		// Update act vertical position
		ActY -= 0.05;
		
		// Update text vertical position
		ZoneY -= 0.05;
	
		// Continue after 50 frames
		if CardTimer < 50
		{
			exit;
		}
		
		// Update act x position
		ActX  = ActX  > Width - 120 ? ActX - 16  : ActX - 0.1;
		
		// Update text x position
		ZoneX = ZoneX < Width - 86  ? ZoneX + 24 : ZoneX + 0.1;
		
		// Fade in after 3 seconds
		if CardTimer == 180
		{	
			if Stage.State != ActStateDefault
			{
				fade_perform(from, black, 1);
					
				Stage.State       = ActStateDefault;
				Stage.TimeEnabled = true;
				Input.IgnoreInput = false;
				InterfaceEnabled  = true;
				CameraEnabled     = true;
			}			
			CardState = 1;	
		}
	}
	else if CardState == 1
	{
		// Update elements positions
		ZonelineX -= 0.2;
		ZonelineY -= 0.05;
		ActX      -= 0.1;
		ActY      -= 0.05;
		ZoneX     += 0.1;
		ZoneY     -= 0.05;
		RibbonX   += 0.15;
		RibbonY   += 2;
		
		// Update disappear speed
		Acceleration += 0.2;
		
		// Disappear
		LineY += Acceleration;
		
		if CardTimer > 205
		{
			RibbonX -= Acceleration;
		}	
		if CardTimer > 220
		{	
			ZonelineX += Acceleration * 6;
			ZoneX	  += Acceleration * 6;
			ActX      -= Acceleration * 6;
		}
		
		// Shift HUD
		if CardTimer >= 235 and InterfaceOffsetX < 0
		{
			InterfaceOffsetX += 5;
		}
		
		// Stop card
		if CardTimer == 300
		{
			CardState = 2;
		}
	}
}