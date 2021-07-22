function ObjBossControllerSetup()
{
	BossTriggered		isVar;
	BossDefeated		isVar;
	ReservedTopBound    isVar;
	ReservedBottomBound isVar;
	
	/* Variable Definitions
	1. ArenaWidth,  default = 400
	2. ArenaHeight, default = 224
	*/
	
	// Set object visibility
	visible = false;
	
	// Set active range
	object_set_range(RangeClose);
	
	// Set triggerbox
	object_set_triggerbox(0, 32, -512, 512);
}