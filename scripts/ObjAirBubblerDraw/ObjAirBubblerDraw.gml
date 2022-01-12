function ObjAirBubblerDraw()
{
	// Draw if not above the water surface
	if Stage.WaterEnabled and y >= Stage.WaterLevel
	{
		draw_self();
	}
}