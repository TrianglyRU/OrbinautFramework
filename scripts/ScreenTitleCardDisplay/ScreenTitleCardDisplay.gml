function ScreenTitleCardDisplay()
{
	// Exit the code after 6 seconds
	if (CardTimer == 360) exit;
	
	// Use title card font
	string_set_font(Game.Font[FontCard], "left");
	
	// Disable background render if we're loading from previous act
	if CardTimer == 0
	{
		if Game.TransitionShiftPlayer[0] != 0 and Stage.ActID != 0
		{
			// Start gameplay early
			fade_perform(from, black, 0);

			BGVisible = false;
			
			Stage.State       = ActStateDefault;
			Stage.TimeEnabled = true;
			Input.IgnoreInput = false;
			InterfaceEnabled  = true;
			CameraEnabled     = true;
		}
		else
		{
			fade_perform(from, black, 1);
		}
	}

	// Count timer
	CardTimer++;
		
	// Count angle
	Angle -= 2;
	
	// Move right line
	var LineX = (Angle > 90 ? ResX / 35 : 0.5) * dcos(Angle);
	var LineY = (Angle > 0  ? ResY / 35 : 0.5) * dsin(Angle);
	
	LineRightX += LineX;
	LineRightY += LineY;
	
	// Move left line
	LineLeftX  -= LineX;
	LineLeftY  -= LineY;
		
	// Scale lines
	if CardTimer < 265
	{
		if Angle < 125 and Angle > 80
		{
			LineScale = min(LineScale + ResX / (ResX * 1.5), 8);
		}
		else if Angle < 80
		{
			LineScale = max(LineScale - ResX / (ResX * 3.5), 4);
		}
	}
	else
	{
		LineScale = max(LineScale - (CardTimer - 265) / 10, 0);
	}
		
	// Move zonename
	if CardTimer >= 50 and CardTimer < 235
	{
		ZoneBottomShift = ZoneBottomShift < 0 ? min(ZoneBottomShift + 16, 0) : ZoneBottomShift + 0.15;
		ZoneTopShift	= ZoneTopShift    > 0 ? max(ZoneTopShift    - 16, 0) : ZoneTopShift - 0.15;
	}
	else if CardTimer >= 235
	{
		ZoneBottomShift += CardTimer - 231;
		ZoneTopShift    -= CardTimer - 231;
	}
		
	// Move ribbon
	if CardTimer >= 70 and CardTimer < 230
	{
		RibbonShift = RibbonShift < -16 ? min(RibbonShift + abs(90 - CardTimer), -16) : RibbonShift + 0.1;
	}
	else if CardTimer >= 230
	{
		RibbonShift -= CardTimer - 226;
	}
	
	// Move act
	if CardTimer >= 80 and CardTimer < 225
	{
		ActShift = min(ActShift + 32, ZoneBottomShift);
	}	
	else if CardTimer >= 235
	{
		ActShift += CardTimer - 231;
	}
	
	// Update edge lines position
	if CardTimer < 255
	{
		var lnspd   = max(max(100 - CardTimer, 0) / 20, 2);
		EdgeLeftX  -= lnspd;
		EdgeRightX += lnspd;
		EdgeLeftY  -= lnspd;
		EdgeRightY += lnspd;
			
		if CardTimer > 40
		{
			if EdgeLeftX < 0
			{
				EdgeLeftX = 32;
			}
			if EdgeRightX > ResX
			{
				EdgeRightX = ResX - 32;
			}
			if EdgeLeftY < ResY - 32 * 2
			{
				EdgeLeftY = ResY - 32;
			}
			if EdgeRightY > 32 * 2
			{
				EdgeRightY = 32;
			}
		}
	}
	else
	{
		EdgeLeftX  -= CardTimer - 252;
		EdgeRightX += CardTimer - 252;
		EdgeLeftY  -= CardTimer - 252;
		EdgeRightY += CardTimer - 252;
	}
	
	// Start gameplay
	if CardTimer == 45
	{
		Stage.State       = ActStateDefault;
		Stage.TimeEnabled = true;
		Input.IgnoreInput = false;
		InterfaceEnabled  = true;
		CameraEnabled     = true;
		
		BGVisible = false;
	}
	// Shift HUD
	if CardTimer >= 260 and InterfaceOffsetX < 0
	{
		InterfaceOffsetX += 5;
	}
	
	// Draw background
	if (BGVisible) draw_sprite_ext(hudCardBackground, 0, 0, 0, 100, 50, 0, c_white, 1);

	// Draw top string undertext
	var NameTop = string_length(Stage.CardNameTop) * 2;
	for (var i = 1; i <= NameTop; i++)
	{
		draw_sprite(hudCardUndertext, 1, ZonenameX - 10 + (8 * i) + ZoneTopShift, ZonenameY + 14);
	}
	draw_sprite(hudCardUndertext, 0, ZonenameX - 10 + ZoneTopShift,										   ZonenameY + 14);
	draw_sprite(hudCardUndertext, 2, ZonenameX - 2  + string_length(Stage.CardNameTop) * 16 + ZoneTopShift, ZonenameY + 14);
	
	// Draw bottom string undertext
	var NameBottom = string_length(Stage.CardNameTop) * 2;
	for (var i = 1; i <= NameBottom; i++)
	{
		draw_sprite(hudCardUndertext, 1, ZonenameX - 30 + (8 * i) + ZoneBottomShift, ZonenameY + 38);
	}
	draw_sprite(hudCardUndertext, 0, ZonenameX - 30 + ZoneBottomShift,											 ZonenameY + 38);
	draw_sprite(hudCardUndertext, 2, ZonenameX - 22 + string_length(Stage.CardNameBottom) * 16 + ZoneBottomShift, ZonenameY + 38);
	
	// Draw strings
	string_display(ZonenameX + ZoneTopShift + 4,		    ZonenameY + 4,      Stage.CardNameTop,    1);
	string_display(ZonenameX + ZoneBottomShift - 16, ZonenameY + 28, Stage.CardNameBottom, 1);
	
	// Draw act number
	draw_sprite(hudCardAct, Stage.ActID, ZonenameX - 83 + string_length(Stage.CardNameBottom) * 16 + ActShift, ZonenameY + 34);

	// Draw lines
	draw_sprite_ext(hudCardLine, 0, LineRightX, LineRightY, 2, LineScale, 315, c_white, 1);
	draw_sprite_ext(hudCardLine, 0, LineLeftX,  LineLeftY,  2, LineScale, 315, c_white, 1);
	
	// Draw ribbon
	draw_sprite(hudCardRibbon, 0, RibbonX, RibbonY + RibbonShift);
	
	// Draw edges
	draw_sprite(hudCardEdge, 0, EdgeLeftX,  EdgeLeftY);
	draw_sprite(hudCardEdge, 0, EdgeRightX, EdgeRightY);
}