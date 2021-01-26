/// @function sensor_active(sensor_id) 
function sensor_active(sensor_id) 
{	
	// Ground sensors
	if sensor_id = Sensor[FloorL] or sensor_id = Sensor[FloorR] 
	{	
		if (!Grounded and (Ysp > 0 or abs(Xsp) > abs(Ysp))) or Grounded and !OnObject
		{
			return true;
		} 
		else
		{
			return false;
		}
	}
	
	// Ceiling sensors
	if sensor_id = Sensor[RoofL] or sensor_id = Sensor[RoofR] 
	{	
		if !Grounded and (Ysp < 0 or abs(Xsp) > abs(Ysp))
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	// Left wall sensor
	if sensor_id = Sensor[WallL]
	{	
		if Grounded
		{
			if (Angle <= 90 or Angle >= 270) and Inertia < 0
			{
				return true;
			}
			return false;
		}
		return !(Xsp > abs(Ysp));
	}
	
	// Right wall sensor
	if sensor_id = Sensor[WallR]
	{
		if Grounded
		{
			if (Angle < 90 or Angle > 270) and Inertia > 0
			{
				return true;
			}
			return false;
		}
		return !(-Xsp > abs(Ysp));
	}
}