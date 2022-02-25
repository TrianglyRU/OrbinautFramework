function RendererDistortionSetup()
{
	/* Please note, that if there is no Stage controller in the room,
	the game will only use a distortion effect assigned to data1
	
	If you don't want a distortion effect in your room, simply
	don't call the function */
	
	switch room
	{
		case Stage_TVZ:
		{
			distortion_set(dist_heat, dist_water, ["GraphicsA", "AnimatedTiles", "GraphicsB"]);
		}
		break;
	}
}