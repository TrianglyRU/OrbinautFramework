/// @ Called in Renderer Controller -> Create Event
function DistortionSetup()
{
	/* Please note that if there is no Stage controller in the room,
	the game will only use a distortion effect assigned to data1 */
	
	switch room
	{
		case Stage_TSZ:
		{
			distortion_set(noone, dist_water, 0.5, ["GraphicsA", "AnimatedTiles", "GraphicsB"], noone);
			distortion_set_bg(noone, dist_water_bg, 0.5, noone);
		}
		break;
	}
}