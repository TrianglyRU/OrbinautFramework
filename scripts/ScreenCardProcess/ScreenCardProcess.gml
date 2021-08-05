function ScreenCardProcess()
{
	// Get card values
	var CardTimer    = CardValue[0];
	var CardState    = CardValue[1];
	var RibbonX	     = CardValue[2];
	var RibbonY	     = CardValue[3];
	var RibbonXSpeed = CardValue[4];
	var LineX		 = CardValue[5];
	var LineY		 = CardValue[6];
	var LineXSpeed   = CardValue[7];
	var LineYSpeed   = CardValue[8];
	var LineAngle    = CardValue[9];
	var ZonelineX    = CardValue[10];
	var ZonelineY    = CardValue[11];
	var ActX		 = CardValue[12];
	var ActY		 = CardValue[13];
	var ZoneX		 = CardValue[14];
	var ZoneY		 = CardValue[15];
	var Acceleration = CardValue[16];

	// Exit if CardState equals 2 (i.e. sequence has ended)
	if CardState == 2
	{
		exit;
	}
	
	// Draw colour line and note
	draw_sprite(spr_card_line, Player.CharacterID, LineX,	   LineY);
	draw_sprite(spr_card_note, 0,				   LineX - 46, LineY + 34);
	
	// Display composition name
	switch Stage.StageMusic
	{
		case StarryNight:
			var CompositionName = "WOOFLE - STARRY NIGHT ZONE ACT 1";
		break;
		case MoonlightQuadrant:
			var CompositionName = "MASAFUMI OGATA - 8TH SPACE"
		break;
		default:
			var CompositionName = "UNKNOWN TRACK";
		break;
	}
	string_set_font(Game.Font[FontDebug], fa_right);
	string_display(LineX - 52, LineY + 40, CompositionName, 1);
	
	// Draw card elements 2
	draw_sprite(spr_card_ribbon,	0,			 RibbonX,      RibbonY);
	draw_sprite(spr_card_logo,	    0,			 RibbonX - 46, 24);
	draw_sprite(spr_card_zoneline,  0,			 ZonelineX,    ZonelineY);
	draw_sprite(spr_card_act,       Stage.ActID, ActX,	       ActY);
	
	// Draw zone name
	string_set_font(Game.Font[FontCard], fa_right);
	string_display(ZoneX, ZoneY, Stage.ZoneName, 1);
	
	// Perform fade
	if !CardTimer
	{
		fade_perform(to, black, 0);
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
			if Stage.State != StageActive
			{
				fade_perform(FadeOut, FadeBlack, 1);
					
				Stage.State       = StageActive;
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
	
	// Update card values in the array
	CardValue[0]  = CardTimer;
	CardValue[1]  = CardState;
	CardValue[2]  = RibbonX;
	CardValue[3]  = RibbonY;
	CardValue[4]  = RibbonXSpeed;
	CardValue[5]  = LineX;
	CardValue[6]  = LineY;
	CardValue[7]  = LineXSpeed;
	CardValue[8]  = LineYSpeed;
	CardValue[9]  = LineAngle;
	CardValue[10] = ZonelineX;
	CardValue[11] = ZonelineY;
	CardValue[12] = ActX;
	CardValue[13] = ActY;
	CardValue[14] = ZoneX;
	CardValue[15] = ZoneY;
	CardValue[16] = Acceleration;
}