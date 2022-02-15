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
			var WaveData = 
			[
				1,2,3,3,2,1,
				0,0,0,0,0,0,0,0,0,0,
			   -1,-2,-3,-3,-2,-1,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
			   -1,-2,-3,-3,-2,-1,
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			];
			
			var WaveData = [-1,-1,-1,-2,-2,-3,-3,-3,-4,-4,-4,-5,-5,-6,-6,-6,-6,-6,-7,-7,-7,-7,-7,-7,-7,-7,-7,-7,-7,-7,-7,-6,-6,-6,-6,-6,-5,-5,-4,-4,-4,-3,-3,-3,-2,-2,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
			distortion_set(WaveData, 2, ["GraphicsA", "AnimatedTiles", "GraphicsB"], 2);
			
			/*var WaveData2 = 
			[
				1,0,0,1,1,0,0,0,0,1,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0
			];
			distortion_set(WaveData2, 1, ["GraphicsA", "AnimatedTiles", "GraphicsB"], 1);*/
		}
		break;
	}
}