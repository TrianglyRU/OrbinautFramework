/// @description Insert description here
// You can write your code in this editor
	
	// Set rotation speed
	RotationSpeed += 10;
	
	// Set angle
	var Ang = 45 * Number - RotationSpeed;
	
	// Set delays
	if Number == 1 or Number == 4 or Number == 7
	{
		var Delay = 0;
	}
	else if Number == 2 or Number == 5 or Number == 8
	{
		var Delay = 3;
	}
	else
	{
		var Delay = 6;
	}
	
	// Set distance
	var Dist = 16;
	
	// Rotate
	x = Player.RecordedPosX[| Delay] + dsin(Ang) * Dist;
	y = Player.RecordedPosY[| Delay] + dcos(Ang) * Dist;
	
	// Animate
	if ( image_speed and  image_index = 7)
	or (!image_speed and !image_index) image_speed *= -1;