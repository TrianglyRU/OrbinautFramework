function ScreenTitleCardDisplay()
{
	// Exit the code if CardState is 2
	if CardState == 2
	{
		exit;
	}
	
	// Draw card elements
	draw_sprite(spr_card_line, Player.CharacterID, LineX,	   LineY);
	draw_sprite(spr_card_note, 0,				   LineX - 46, LineY + 34);
	
	// Draw composition name
	switch Game.NormalTrack[TrackID]
	{
		case StarryNight:
			var CompositionName = "WOOFER - STARRY NIGHT ZONE ACT 1";
		break;
		case MoonlightQuadrant:
			var CompositionName = "MASAFUMI OGATA - 8TH SPACE"
		break;
		default:
			var CompositionName = "UNKNOWN TRACK";
		break;
	}
	string_set_font(Game.Font[FontDebug], "right");
	string_display(LineX - 52, LineY + 40, CompositionName, 1);
	
	// Draw card elements 2
	draw_sprite(spr_card_ribbon,	0,			 RibbonX,      RibbonY);
	draw_sprite(spr_card_logo,	    0,			 RibbonX - 46, 24);
	draw_sprite(spr_card_zoneline,  0,			 ZonelineX,    ZonelineY);
	draw_sprite(spr_card_act,       Stage.ActID, ActX,	       ActY);
	
	// Draw zone name
	string_set_font(Game.Font[FontCard], "right");
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
		ZoneX = ZoneX < Width - 84  ? ZoneX + 24 : ZoneX + 0.1;
		
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