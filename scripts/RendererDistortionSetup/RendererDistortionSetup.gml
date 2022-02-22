function RendererDistortionSetup()
{
	/* Distortion Boundary Types:
	0 - on the entire screen;
	1 - only above water level, requires Stage Controller to exist;
	2 - only below water level, requires Stage Controller to exist;
	*/
	
	// Setup wave distortion data
	switch room
	{
		case Stage_TVZ:
		{
			/*
			var WaveData1 = 
			[
				1,2,3,3,2,1,
				0,0,0,0,0,0,0,0,0,0,
			   -1,-2,-3,-3,-2,-1,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
			   -1,-2,-3,-3,-2,-1,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			];
			var WaveData2 = 
			[
				1,0,0,1,1,0,0,0,0,1,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0
			];
			*/
			distortion_set(wave_heat, wave_underwater, 1, 2, ["GraphicsA", "AnimatedTiles", "GraphicsB"], 2);
		}
		break;
	}
}