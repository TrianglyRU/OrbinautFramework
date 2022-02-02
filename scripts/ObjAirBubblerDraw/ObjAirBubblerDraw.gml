function ObjAirBubblerDraw()
{
	if Stage.WaterEnabled and y >= Stage.WaterLevel
	{
		draw_self();
	}
}