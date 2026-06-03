/// @self obj_player
function scr_player_balance()
{
	if action == ACTION.SPIN_DASH || action == ACTION.DASH || spd != 0
	{
		return;
	}
	
	if global.player_physics == PHYSICS.SK
	{
		if input_down.down || input_down.up && global.dash
		{
			return;
		}
	}
	
	if on_object == noone
	{
		if math_get_quadrant(angle) != QUADRANT.DOWN
		{
			return;
		}
		
		var _floor_data = tile_raycast_v(x, y + radius_y - 1, 1, secondary_layer);
		var _floor_dist = _floor_data[0];
		
		if _floor_dist < 12
		{
			return;
		}
		
		var _floor_angle = _floor_data[1];
		
		if _floor_angle == TILE_EMPTY_ANGLE
		{
			_floor_angle = 0;
		}
		
		var _slope_diff = abs(angle % 180 - _floor_angle % 180);
		
		if _slope_diff >= 45 && _slope_diff <= 135
		{
			return;
		}
		
		var _angle_left = tile_raycast_v(x - radius_x, y + radius_y - 1, 1, secondary_layer)[1];
		var _angle_right = tile_raycast_v(x + radius_x - 1, y + radius_y - 1, 1, secondary_layer)[1];
		
		if _angle_left == TILE_EMPTY_ANGLE && _angle_right == TILE_EMPTY_ANGLE
		|| _angle_left != TILE_EMPTY_ANGLE && _angle_right != TILE_EMPTY_ANGLE
		{
			return;
		}
		
		if _angle_left == TILE_EMPTY_ANGLE
		{	
			_balance_left(tile_raycast_v(x + 5, y + radius_y - 1, 1, secondary_layer)[0] >= 12);
		}
		else if _angle_right == TILE_EMPTY_ANGLE
		{
			_balance_right(tile_raycast_v(x - 6, y + radius_y - 1, 1, secondary_layer)[0] >= 12);
		}
	}
	else if instance_exists(on_object) && on_object.solid_balance
	{
		var _px = floor(x);
		var _left_edge = floor(on_object.bbox_left) + 2;
		var _right_edge = floor(on_object.bbox_right) - 2;
		
		if _px < _left_edge
		{
			_balance_left(_px < _left_edge - 4);
		}
		else if _px > _right_edge
		{
			_balance_right(_px > _right_edge + 3);
		}
	}
}

/// @self scr_player_balance
function _balance_left(_panic_cond)
{
	switch player_type
	{
		case PLAYER.SONIC:
			
			if super_timer > 0
			{
				animation = ANIM.BALANCE;
				facing = -1;
			}
			else if !_panic_cond
			{
				animation = facing == -1 ? ANIM.BALANCE : ANIM.BALANCE_FLIP;
			}
			else if facing == 1
			{
				animation = ANIM.BALANCE_TURN;
				facing = -1;
			}
			else if animation != ANIM.BALANCE_TURN
			{
				animation = ANIM.BALANCE_PANIC;
			}
			
		break;
			
		case PLAYER.TAILS:
		case PLAYER.AMY:
				
			animation = ANIM.BALANCE;
			facing = -1;
			
		break;
			
		case PLAYER.KNUCKLES:
			
			if facing == -1
			{
				animation = ANIM.BALANCE;
			}
			else if animation != ANIM.BALANCE_FLIP
			{
				animation = ANIM.BALANCE_FLIP;
				facing = -1;
			}
			
		break;
	}
}

/// @self scr_player_balance
function _balance_right(_panic_cond)
{	
	switch player_type
	{
		case PLAYER.SONIC:
			
			if super_timer > 0
			{
				animation = ANIM.BALANCE;
				facing = 1;
			}
			else if !_panic_cond
			{
				animation = facing == 1 ? ANIM.BALANCE : ANIM.BALANCE_FLIP;
			}
			else if facing == -1
			{
				animation = ANIM.BALANCE_TURN;
				facing = 1;
			}
			else if animation != ANIM.BALANCE_TURN
			{
				animation = ANIM.BALANCE_PANIC;
			}

		break;
		
		case PLAYER.TAILS:
		case PLAYER.AMY:
				
			animation = ANIM.BALANCE;
			facing = 1;
			
		break;
		
		case PLAYER.KNUCKLES:
			
			if facing == 1
			{
				animation = ANIM.BALANCE;
			}
			else if animation != ANIM.BALANCE_FLIP
			{
				animation = ANIM.BALANCE_FLIP;
				facing = 1;
			}
			
		break;
	}
}