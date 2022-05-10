/// @description Startup
// You can write your code in this editor

	#region Debug Startup
	{
		DebugPositions = 0;
		DebugFPS	   = 0;
		DebugVariables = 0;
		DebugSolids	   = 0;
		DebugHitboxes  = 0;
		DebugTriggers  = 0;
	}
	#endregion
	
	#region HUD Startup
	{
		Enabled = true;
		OffsetX = 0;
		OffsetY = 0;
	}
	#endregion
	
	#region GameOver Startup
	{
		GameOverValue[0] = global.ScreenBuffer;
		GameOverValue[1] = global.Width + global.ScreenBuffer;
	}
	#endregion
	
	#region Pause Startup
	{
		PauseValue = 0;
		PauseTimer = 0;
	}
	#endregion
	
	#region Card Startup
	{
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
	
		// Initialise variables
		CardValue[0] = 0;
		CardValue[1] = 0;	
		CardValue[2] = global.Height / 2;
		CardValue[3] = -108;
		CardValue[4] = -100;
		CardValue[5] = 1;
		CardValue[6] = -48;
		CardValue[7] = global.Width * 2 + 128;
	
		// Disable all input
		Input.IgnoreInput = true;
	
		// Turn screen into black
		fade_perform(ModeInto, BlendBlack, 0);
	}
	#endregion
	
	#region Results Startup
	{
		/* Value Table Reference
		----------------------------
		Value[0]  - Timer
		Value[1]  - Character Head X
		Value[2]  - 'CHARACTER' X
		Value[3]  - 'GOT THROUGH' X
		Value[4]  - 'SCORE' X
		Value[5]  - 'TIME BONUS' X
		Value[6]  - 'RINGS BONUS' X
		Value[7]  - 'ACT' X
		Value[8]  - State
		Value[9]  - Ring Bonus
		Value[10] - Time Bonus
		Value[11] - Continue flag
		----------------------------
		*/
	
		// Initialise variables
		ResultsValue[0]  = 0;
		ResultsValue[1]  = 400;
		ResultsValue[2]  = 400;
		ResultsValue[3]  = 400;
		ResultsValue[4]  = 400;
		ResultsValue[5]  = 440;
		ResultsValue[6]  = 480;
		ResultsValue[7]  = 560;
		ResultsValue[8]  = 0;
		ResultsValue[9]  = 0;
		ResultsValue[10] = 0;
		ResultsValue[11] = 0;
	}
	#endregion