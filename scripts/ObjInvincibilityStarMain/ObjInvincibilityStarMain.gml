function ObjInvincibilityStarMain()
{
	// Destroy if player is not under invincibility bonus
	if !Player.InvincibleBonus or Player.SuperState
	{
		instance_destroy();
	}
	
	// Set rotation speed
	RotationSpeed += 10 * Player.Facing;
	
	// Set angle
	var Angle = 45 * ID - RotationSpeed;
	
	// Set delays
	if ID == 1 or ID == 4 or ID == 7
	{
		var Delay = 0;
	}
	else if ID == 2 or ID == 5 or ID == 8
	{
		var Delay = 3;
	}
	else
	{
		var Delay = 6;
	}
	
	// Set distance
	var Distance = 16;
	
	// Rotate
	x = Player.RecordedPosX[| Delay] + dsin(Angle) * Distance;
	y = Player.RecordedPosY[| Delay] + dcos(Angle) * Distance;
}