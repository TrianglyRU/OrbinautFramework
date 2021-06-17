function ScreenTitleCardSetup()
{
	// Disable global input
	Input.IgnoreInput = true;
	
	// Background flag
	BGVisible = true;
	
	// Get resolution
	ResX = Game.ResolutionWidth;
	ResY = Game.ResolutionHeight;
	
	// Set default lines position
	LineLeftX  = -144;
	LineLeftY  = ResY / 2;
	LineRightX = ResX + 144;
	LineRightY = ResY / 2;
	LineScale  = 1;
	
	// Set ribbon default position
	RibbonX = ResX / 2 - 72;
	RibbonY = 0;
	
	// Set default edge decorations position
	EdgeLeftX  = 176;
	EdgeLeftY  = ResY + 112;
	EdgeRightX = ResX - 176;
	EdgeRightY = -112;
	
	// Set default zonename position
	ZonenameX  = ResX / 2 + 16;
	ZonenameY  = ResY / 2 - 32;
	
	// Set shifts
	ZoneBottomShift = -ResX;
	ZoneTopShift    =  ResX;
	ActShift		= -ResX;
	RibbonShift     = -200;
	
	// Set timers
	CardTimer = 0;
	Angle     = 180;
	
	Timer   = 0;
	State = 0;
	ScreenAlpha = 1;
	RibbonX		 = -16;
	RibbonY		 = 0;
	RibbonXSpeed = 3;
	LineX		 = -100;
	LineY		 =  Game.ResolutionHeight - 58;
	LineXSpeed   =  28;
	LineYSpeed   =  0;
	LineAngle    =  0;
	Ribbon2X = Game.ResolutionWidth - 32;
	Ribbon2Y = 0;
	Ribbon2Speed = 3;
	CharX	   = 0;
	CharY	   = Game.ResolutionHeight - 12;
	CharYSpeed = 0;
	ZonelineX      = Game.ResolutionWidth + 48;
	ZonelineY	   = 75;
	ZonelineXSpeed = -15;
	ActX		   = Game.ResolutionWidth;
	ActY		   = 95;
	ZoneX      = 0;
	ZoneY      = 64;
	Acceleration = 0;
}