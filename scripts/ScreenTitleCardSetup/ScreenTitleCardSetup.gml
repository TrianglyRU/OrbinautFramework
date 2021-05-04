function ScreenTitleCardSetup()
{
	// Disable global input
	Input.IgnoreInput = true;
	
	// Get resolution
	ResX = Game.ResolutionWidth;
	ResY = Game.ResolutionHeight;
	
	// Backgroun flag
	BGVisible = true;
	
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
}