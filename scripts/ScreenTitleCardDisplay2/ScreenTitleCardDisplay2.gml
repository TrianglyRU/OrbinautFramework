function ScreenTitleCardDisplay2()
{
	if State == 2
	{
		exit;
	}
	
	// Use title card font
	string_set_font(Game.Font[FontCard], "right");
	
	draw_sprite(spr_hud_line,      0, LineX,									   LineY);
	draw_sprite(spr_hud_ribbon,	   0, RibbonX,									   RibbonY);
	draw_sprite(spr_hud_zoneline,  0, ZonelineX,								   ZonelineY);
	draw_sprite(spr_hud_act,  0, ActX,								   ActY);
	string_display(ZoneX, ZoneY + 4, Stage.CardNameTop, 1);
	//draw_sprite(spr_hud_zone,  0, ZoneX,								   ZoneY);
	
	// Count card
	Timer++;

	if State == 0
	{
		// Update ribbon speed
		RibbonXSpeed = max(RibbonXSpeed - 0.05, 0.15);
	
		// Update ribbon position
		RibbonX += RibbonXSpeed;
		RibbonY += 2;
		
		// Update ribbon position
		//Ribbon2X -= RibbonXSpeed;
		
		// Loop ribbon vertically
		if RibbonY == 32
		{
			RibbonY -= 32;	
		}
		
		// Loop ribbon vertically
		if RibbonY == -32
		{
			RibbonY += 32;	
		}
	
		// Update line speed
		if LineX < Game.ResolutionWidth
		{
			LineXSpeed -= (Timer / Game.ResolutionWidth) * 5
		}
		else
		{
			LineXSpeed = 0;
		}
		LineAngle += 2;
		LineYSpeed = dsin(LineAngle) / 10;
	
		// Update line position
		LineX += LineXSpeed;
		LineY += LineYSpeed;
	
		// Update char position
		CharX += 4;
		
		// Continue after 30 frames
		if Timer < 30 
		{
			exit;
		}
		
		if ZonelineX > 60
		{
			ZonelineX = max(60, ZonelineX - 32);
		}
		else
		{
			ZonelineX -= 0.2;
		}
		
		ZonelineY -= 0.05;
		ActY -= 0.05;
		ZoneY -= 0.05;
	
		// Continue after 50 frames
		if Timer < 50
		{
			exit;
		}
	
		ActX  = ActX  > Game.ResolutionWidth - 120 ? ActX - 16  : ActX - 0.1;
		ZoneX = ZoneX < Game.ResolutionWidth - 86  ? ZoneX + 24 : ZoneX + 0.1;
		
		if Timer == 180
		{
			
			Stage.State       = ActStateDefault;
			Stage.TimeEnabled = true;
			Input.IgnoreInput = false;
			InterfaceEnabled  = true;
			CameraEnabled     = true;
			
			State = 1;
			fade_perform(from, black, 1);
		}
	}
	else if State == 1
	{
		Acceleration += 0.2;

		ZonelineX -= 0.2;
		ZonelineY -= 0.05;
		ActY -= 0.05;
		ZoneY -= 0.05;
		
		CharX   += 4 + Acceleration * 5;
		LineY     += Acceleration;
		
		RibbonX += 0.15;
		RibbonY += 2;
		ZoneX += 0.1;
		ActX  -= 0.1;
		
		if Timer > 205
		{
			RibbonX -= Acceleration;
		}
		
		if Timer > 220
		{	
			ZonelineX += Acceleration * 6;
			ZoneX	  += Acceleration * 6;
			ActX      -= Acceleration * 6;
		}
		
		if Timer == 260
		{
			State = 2;
		}
	}
}