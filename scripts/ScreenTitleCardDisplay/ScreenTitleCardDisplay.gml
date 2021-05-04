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
			fade_perform(from, black, 0);
			BGVisible = false;
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
	LineRightX += (Angle > 90 ? ResX / 36 : 0.5) * dcos(Angle);
	LineRightY += (Angle > 0  ? ResY / 36 : 0.5) * dsin(Angle);
	
	// Move left line
	LineLeftX  -= (Angle > 90 ? ResX / 36 : 0.5) * dcos(Angle);
	LineLeftY  -= (Angle > 0  ? ResY / 36 : 0.5) * dsin(Angle);
		
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
	
	// Stop drawing card background
	if CardTimer == 50
	{
		BGVisible = false;
	}

	// Shift HUD
	if CardTimer >= 260 and InterfaceOffsetX < 0
	{
		InterfaceOffsetX += 5;
	}
	
	// Start gameplay if background does not display
	if !BGVisible
	{
		Stage.State		   = ActStateDefault;
		Input.IgnoreInput  = false;
		Stage.TimeEnabled  = true;
		InterfaceEnabled   = true;
		CameraEnabled      = true;
	}
	
	// Sync positions with camera movement
	var scrZoneX      = CameraX + ZonenameX;
	var scrZoneY      = CameraY + ZonenameY;
	var scrLineRightX = CameraX + LineRightX;
	var scrLineRightY = CameraY + LineRightY;
	var scrLineLeftX  = CameraX + LineLeftX;
	var scrLineLeftY  = CameraY + LineLeftY;
	var scrRibbonX    = CameraX + RibbonX;
	var scrRibbonY    = CameraY + RibbonY;
	var scrEdgeRightX = CameraX + EdgeRightX;
	var scrEdgeRightY = CameraY + EdgeRightY;
	var scrEdgeLeftX  = CameraX + EdgeLeftX;
	var scrEdgeLeftY  = CameraY + EdgeLeftY;
	
	// Draw background
	if (BGVisible) draw_sprite_ext(hudCardBackground, 0, CameraX, CameraY, 100, 50, 0, c_white, 1);

	// Draw top string undertext
	for (var i = 1; i <= string_length(Stage.CardNameTop) * 2; i++)
	{
		draw_sprite(hudCardUndertext, 1, scrZoneX - 10 + (8 * i) + ZoneTopShift, scrZoneY + 14);
	}
	draw_sprite(hudCardUndertext, 0, scrZoneX - 10 + ZoneTopShift,										   scrZoneY + 14);
	draw_sprite(hudCardUndertext, 2, scrZoneX - 2  + string_length(Stage.CardNameTop) * 16 + ZoneTopShift, scrZoneY + 14);
	
	// Draw bottom string undertext
	for (var i = 1; i <= string_length(Stage.CardNameBottom) * 2; i++)
	{
		draw_sprite(hudCardUndertext, 1, scrZoneX - 30 + (8 * i) + ZoneBottomShift, scrZoneY + 38);
	}
	draw_sprite(hudCardUndertext, 0, scrZoneX - 30 + ZoneBottomShift,											 scrZoneY + 38);
	draw_sprite(hudCardUndertext, 2, scrZoneX - 22 + string_length(Stage.CardNameBottom) * 16 + ZoneBottomShift, scrZoneY + 38);
	
	// Draw strings
	string_display(scrZoneX + ZoneTopShift,		    scrZoneY,      Stage.CardNameTop,    1);
	string_display(scrZoneX + ZoneBottomShift - 20, scrZoneY + 24, Stage.CardNameBottom, 1);
	
	// Draw act number
	draw_sprite(hudCardAct, Stage.ActID, scrZoneX - 83 + string_length(Stage.CardNameBottom) * 16 + ActShift, scrZoneY + 34);

	// Draw lines
	draw_sprite_ext(hudCardLine, 0, scrLineRightX, scrLineRightY, 2, LineScale, 315, c_white, 1);
	draw_sprite_ext(hudCardLine, 0, scrLineLeftX,  scrLineLeftY,  2, LineScale, 315, c_white, 1);
	
	// Draw ribbon
	draw_sprite(hudCardRibbon, 0, scrRibbonX, scrRibbonY + RibbonShift);
	
	// Draw edges
	draw_sprite(hudCardEdge, 0, scrEdgeLeftX,  scrEdgeLeftY);
	draw_sprite(hudCardEdge, 0, scrEdgeRightX, scrEdgeRightY);
}