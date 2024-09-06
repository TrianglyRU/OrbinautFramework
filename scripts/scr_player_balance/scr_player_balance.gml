/// @function scr_player_balance
function scr_player_balance()
{
	gml_pragma("forceinline");
	
	if action == ACTION_SPINDASH || action == ACTION_DASH
	{
		exit;
	}
	
	if spd_ground != 0 
	{
		exit;
	}
	
	if global.player_physics == PHYSICS_SK
	{
		if input_down.down || input_down.up // && global.dash	You can enable the Dash check here for consistency
		{
			exit;
		}
	}

	/// @method m_local_balance_left
	var m_local_balance_left = function(_panic_cond)
	{
		if PlayerType == PLAYER_TAILS || PlayerType == PLAYER_AMY || PlayerType == PLAYER_SONIC && super_timer > 0
		{
			animation = ANI_BALANCE;
			facing = DIRECTION.NEGATIVE;
			exit;
		}
		
		if PlayerType == PLAYER_KNUCKLES
		{
			if facing == DIRECTION.NEGATIVE
			{
				animation = ANI_BALANCE;
			}
			else if animation != ANI_BALANCE_FLIP
			{
				animation = ANI_BALANCE_FLIP;
				facing = DIRECTION.NEGATIVE;
			}
			
			exit;
		}
		
		if !_panic_cond
		{
			animation = facing == DIRECTION.NEGATIVE ? ANI_BALANCE : ANI_BALANCE_FLIP;
		}
		else if facing == DIRECTION.POSITIVE
		{
			animation = ANI_BALANCE_TURN;
			facing = DIRECTION.NEGATIVE;
		}
		else if animation != ANI_BALANCE_TURN
		{
			animation = ANI_BALANCE_PANIC;
		}
	}
	
	/// @method m_local_balance_right
	var m_local_balance_right = function(_panic_cond)
	{
		if PlayerType == PLAYER_TAILS || PlayerType == PLAYER_AMY || PlayerType == PLAYER_SONIC && super_timer > 0
		{
			animation = ANI_BALANCE;
			facing = DIRECTION.POSITIVE;
			
			exit;
		}
		
		if PlayerType == PLAYER_KNUCKLES
		{
			if facing == DIRECTION.POSITIVE
			{
				animation = ANI_BALANCE;
			}
			else if animation != ANI_BALANCE_FLIP
			{
				animation = ANI_BALANCE_FLIP;
				facing = DIRECTION.POSITIVE;
			}
			
			exit;
		}
		
		if !_panic_cond
		{
			animation = facing == DIRECTION.POSITIVE ? ANI_BALANCE : ANI_BALANCE_FLIP;
		}
		else if facing == DIRECTION.NEGATIVE
		{
			animation = ANI_BALANCE_TURN;
			facing = DIRECTION.POSITIVE;
		}
		else if animation != ANI_BALANCE_TURN
		{
			animation = ANI_BALANCE_PANIC;
		}
	}

	// Balance on the ground
	if on_object == noone
	{
		if math_get_quadrant(angle) > QUADRANT.DOWN
		{
			exit;
		}
		
		var _y = y + radius_y;
		var _floor_dist = tile_find_v(x, _y, DIRECTION.POSITIVE, tile_layer)[0];	
		
		if _floor_dist < 12
		{
			exit;
		}
		
		var _angle_left = tile_find_v(x - radius_x, _y, DIRECTION.POSITIVE, tile_layer)[1];
		var _angle_right = tile_find_v(x + radius_x, _y, DIRECTION.POSITIVE, tile_layer)[1];
		
		if _angle_left == ANGLE_EMPTY && _angle_right == ANGLE_EMPTY
		|| _angle_left != ANGLE_EMPTY && _angle_right != ANGLE_EMPTY
		{
			exit;
		}
		
		if _angle_left == ANGLE_EMPTY
		{	
			var _left_dist = tile_find_v(x + 6, _y, DIRECTION.POSITIVE, tile_layer)[0];
			{
				m_local_balance_left(_left_dist >= 12);
			}
		}
		else if _angle_right == ANGLE_EMPTY
		{
			var _right_dist = tile_find_v(x - 6, _y, DIRECTION.POSITIVE, tile_layer)[0];
			{
				m_local_balance_right(_right_dist >= 12);
			}
		}
		
		exit;
	}

	// Balance on the object
	if !instance_exists(on_object)
	{	
		exit;
	}
	
	var _object_data = on_object.data_solid;
	
	if _object_data.no_balance
	{
		exit;
	}
	
	var _player_x = floor(_object_data.radius_x - on_object.x + x);
	var _left_edge = 2;
	var _right_edge = _object_data.radius_x * 2 - _left_edge;
	
	if _player_x < _left_edge
	{
		m_local_balance_left(_player_x < _left_edge - 4);
	}
	else if _player_x > _right_edge
	{
		m_local_balance_right(_player_x > _right_edge + 4);
	}
}