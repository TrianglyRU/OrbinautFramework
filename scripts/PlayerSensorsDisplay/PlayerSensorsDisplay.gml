function PlayerSensorsDisplay()
{	
	for (var i = 0; i < 6; i += 1)
	{
		if sensor_active(Sensor[i])
		{
			draw_point_colour(Sensor[i][xPos], Sensor[i][yPos], $00F000);
		}
	}
}