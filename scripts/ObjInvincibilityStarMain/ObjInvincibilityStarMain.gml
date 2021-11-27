function ObjInvincibilityStarMain()
{
	// Destroy if player is not under invincibility bonus
	if !Player.InvincibleBonus or Player.SuperState
	{
		instance_destroy();
	}
	
	// Loop through frames
	FrameValue[0] = loop_value(FrameValue[0] + 1, 0, 12);
	FrameValue[1] = loop_value(FrameValue[1] + 1, 0, 10);
	
	// Define a specific frame for each star
	switch ID
	{
		case 0: image_index = FrameTable1[FrameValue[0]];	  break;
		case 1: image_index = FrameTable1[FrameValue[0] + 6]; break;
		case 2: image_index = FrameTable2[FrameValue[0]];	  break;
		case 3: image_index = FrameTable2[FrameValue[0] + 6]; break;
		case 4: image_index = FrameTable3[FrameValue[1]];     break;
		case 5: image_index = FrameTable3[FrameValue[1] + 5]; break;
		case 6: 
		case 7: image_index = FrameTable4[FrameValue[0]];	  break;
	}
	
	// Set rotation angle
	Angle        = 45 * ID - AngleOffset;
	AngleOffset += 11.25 * Player.Facing mod 360;
 
	// Set delays
	switch ID
	{
		case 0: case 4: var Delay = 8; break;
		case 1: case 5: var Delay = 6; break;
		case 2: case 6: var Delay = 4; break;
		case 3: case 7: var Delay = 0; break;
	}

	// Rotate
	x = Player.RecordedPosX[| Delay] + dsin(Angle) * 16;
	y = Player.RecordedPosY[| Delay] + dcos(Angle) * 16;
}