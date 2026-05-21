if !instance_exists(player) || player.item_inv_timer == 0
{
	instance_destroy();
	return;
}

frame_index[0] = (frame_index[0] + 1) % 12;
frame_index[1] = (frame_index[1] + 1) % 10;

var _delay;

switch star_index
{
	case 0:	
		image_index = frame_table1[frame_index[0]];	_delay = 9;
	break;
	
	case 1:	
		image_index = frame_table1[frame_index[0] + 6]; _delay = 6;
	break;
	
	case 2:	
		image_index = frame_table2[frame_index[0]];	_delay = 3;
	break;
	
	case 3:
		image_index = frame_table2[frame_index[0] + 6]; _delay = 0;
	break;
		
	case 4:	 
		image_index = frame_table3[frame_index[1]]; _delay = 9;
	break;
	
	case 5:	 
		image_index = frame_table3[frame_index[1] + 5]; _delay = 6; 
	break;
	
	case 6:
		image_index = frame_table4[frame_index[0]]; _delay = 3;
	break;
	
	case 7:
		image_index = frame_table4[frame_index[0]]; _delay = 0;
	break;
}

angle = 45 * star_index - angle_offset;
angle_offset += 11.25 * player.facing;

var _position_data = player.recorded_data[| _delay];
var _player_x;
var _player_y;

if _position_data != undefined
{
	_player_x = _position_data[2];
	_player_y = _position_data[3];
}
else
{
	_player_x = floor(player.x);
	_player_y = floor(player.y);
}

x = math_oscillate_x(_player_x, angle, 16);
y = math_oscillate_y(_player_y, angle, 16);