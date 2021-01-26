function PlayerPushPerform()
{
	if Sensor[WallL][Dist] <= 0 and Input.Left 
	or Sensor[WallR][Dist] <= 0 and Input.Right 
	{
		Pushing = true;
	} 
	else 
	{
		Pushing = false;
	}
}