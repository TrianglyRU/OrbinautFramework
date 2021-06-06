function PlayerDebugModeControl()
{
	// Force flags
	Death		   = false;
	AllowCollision = false;
	
	// Increase speed
	if Input.Left or Input.Down or Input.Right or Input.Up
	{
		DebugSpeed = min(DebugSpeed + 0.046875, 16);
	}
	else
	{
		DebugSpeed = 0;
	}
	
	// Update player position
	if (Input.Left)  PosX -= DebugSpeed;
	if (Input.Right) PosX += DebugSpeed;
	if (Input.Up)    PosY -= DebugSpeed;
	if (Input.Down)  PosY += DebugSpeed;
	
	// Update current object
	if Input.CPress
	{
		DebugItem++;
		DebugItem = loop_value_range(DebugItem, 0, array_length(DebugList));
	}
	
	// Spawn current object
	if Input.APress
	{
		instance_create(floor(PosX), floor(PosY), DebugList[DebugItem]);
	}
}