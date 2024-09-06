if !instance_exists(TargetPlayer) || TargetPlayer.super_timer > 0 || TargetPlayer.item_inv_timer == 0
{
	instance_destroy();
	exit;
}

frame_number[0] = (frame_number[0] + 1) % 12;
frame_number[1] = (frame_number[1] + 1) % 10;

// Determine the image index based on StarID and frame number
switch StarID
{
	case 0:  image_index = frame_table1[frame_number[0]];	
	break;
	case 1:  image_index = frame_table1[frame_number[0] + 6];
	break;
	case 2:  image_index = frame_table2[frame_number[0]];	
	break;
	case 3:  image_index = frame_table2[frame_number[0] + 6]; 
	break;
	case 4:  image_index = frame_table3[frame_number[1]];     
	break;
	case 5:  image_index = frame_table3[frame_number[1] + 5]; 
	break;
	default: image_index = frame_table4[frame_number[0]];	  
	break;
}

// Set delay based on StarID
var _delay = 0;
switch StarID
{
	case 0: case 4: 
		_delay = 9;
	break;
	case 1: case 5: 
		_delay = 6;
	break;
	case 2: case 6:
		_delay = 3;
	break;
}

// Calculate the angle and adjust the offset
angle = 45 * StarID - angle_offset;
angle_offset += 11.25 * TargetPlayer.facing;

var _position_data = TargetPlayer.ds_record_data[| _delay];
var _player_x = _position_data[2];
var _player_y = _position_data[3];
x = obj_oscillate_x(_player_x, angle, 16);
y = obj_oscillate_y(_player_y, angle, 16);