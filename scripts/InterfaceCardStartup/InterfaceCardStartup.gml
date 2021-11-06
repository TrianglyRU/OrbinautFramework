function InterfaceCardStartup()
{
	// Disable all input
	Input.IgnoreInput = true;
	
	// Turn screen black
	fade_perform(ModeInto, BlendBlack, 0);
	
	/* Value Table Reference
	------------------------
	Value[0] - Timer
	Value[1] - State
	Value[2] - Ribbon Y
	Value[3] - Ribbon X
	Value[4] - Logo X
	Value[5] - Logo Scale
	Value[6] - Act Number X
	Value[7] - Zone Name X
	------------------------
	*/
	
	// Set values
	CardValue[0] = 0;
	CardValue[1] = 0;	
	CardValue[2] = Game.Height / 2;
	CardValue[3] = -108;
	CardValue[4] = -100;
	CardValue[5] = 1;
	CardValue[6] = -48;
	CardValue[7] = Game.Width * 2 + 128;
}