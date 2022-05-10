/// @description Main
// You can write your code in this editor

	if !Player.InvincibleBonus or Player.SuperState
	{
		instance_destroy(); return;
	}
	
	// Loop through frames
	FrameValue[0] = loop_value(FrameValue[0] + 1, 0, 11);
	FrameValue[1] = loop_value(FrameValue[1] + 1, 0, 9);
	
	// Define a specific frame for each star
	switch ID
	{
		case 0:  image_index = FrameTable1[FrameValue[0]];	   break;
		case 1:  image_index = FrameTable1[FrameValue[0] + 6]; break;
		case 2:  image_index = FrameTable2[FrameValue[0]];	   break;
		case 3:  image_index = FrameTable2[FrameValue[0] + 6]; break;
		case 4:  image_index = FrameTable3[FrameValue[1]];     break;
		case 5:  image_index = FrameTable3[FrameValue[1] + 5]; break;
		default: image_index = FrameTable4[FrameValue[0]];	   // 6, 7
	}
	
	// Set rotation data
	switch ID
	{
		case 0: case 4: var Delay = 9; break;
		case 1: case 5: var Delay = 6; break;
		case 2: case 6: var Delay = 3; break;
		case 3: case 7: var Delay = 0; break;
	}
	Angle        = 45 * ID - AngleOffset;
	AngleOffset += 11.25 * Player.Facing;
 
	// Rotate
	x = round(Player.RecordedPosX[| Delay] + dsin(Angle) * 16);
	y = round(Player.RecordedPosY[| Delay] + dcos(Angle) * 16);