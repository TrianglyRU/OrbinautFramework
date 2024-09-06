/// @self
/// @description Checks for solid collision between the calling object and a player object.
/// @param {Id.Instance} player The player object instance.
/// @param {Enum.SOLIDCOLLISION} type The type of collision.
/// @returns {Bool}
function obj_check_solid(_player, _type)
{
	if _player.state >= PLAYER_STATE_NO_CONTROL
	{
		return false;
	}

	var _data_solid = data_solid;
	
	var _pid = _player.player_index;			
	var _rx = _data_solid.radius_x;
	var _ry = _data_solid.radius_y;
	var _ox = _data_solid.offset_x;
	var _oy = _data_solid.offset_y;
	var _side_colour = $00FF00;
	var _push_colour = $FFFF00;
	
	// Visualise collision if debugging
	var _do_debug = global.debug_collision == 3;
	var _ds_list_side = c_framework.collision.ds_solid_side;
	var _ds_list_push = c_framework.collision.ds_solid_push;

	// Handle different types of solid collisions
	switch _type
	{
		case SOLIDCOLLISION.PUSH:
		
			if _do_debug && ds_list_find_index(_ds_list_push, id) == -1
			{
				var _left = x - _rx + _ox;
				var _right = x + _rx + _ox;
				var _top = y - _ry + _oy;
				var _bottom = y + _ry + _oy;
				var _width = 4;

				ds_list_add(_ds_list_push, _left, _top, _left + _width, _bottom, _right - _width, _top, _right, _bottom, _push_colour, id);
			}

			return _data_solid.push_flags[_pid] == true;

		case SOLIDCOLLISION.TOP:
		
			if _do_debug && ds_list_find_index(_ds_list_side, id) == -1
			{
				ds_list_add(_ds_list_side, x - _rx + _ox, y - _ry + _oy - 1, x + _rx + _ox, y + _oy - 1, _side_colour, id);
			}

			return _data_solid.touch_flags[_pid] == ENGINE_COLLISION_TOUCH_TOP;

		case SOLIDCOLLISION.BOTTOM:
		
			if _do_debug && ds_list_find_index(_ds_list_side, id) == -1
			{
				ds_list_add(_ds_list_side, x - _rx + _ox, y + _oy + 1, x + _rx + _ox, y + _ry + _oy, _side_colour, id);
			}

			return _data_solid.touch_flags[_pid] == ENGINE_COLLISION_TOUCH_BOTTOM;

		case SOLIDCOLLISION.LEFT:
		
			if _do_debug && ds_list_find_index(_ds_list_side, id) == -1
			{
				ds_list_add(_ds_list_side, x - _rx + _ox - 1, y - _ry + _oy, x + _ox - 1, y + _ry + _oy, _side_colour, id);
			}

			return _data_solid.touch_flags[_pid] == ENGINE_COLLISION_TOUCH_LEFT;

		case SOLIDCOLLISION.RIGHT:
		
			if _do_debug && ds_list_find_index(_ds_list_side, id) == -1
			{
				ds_list_add(_ds_list_side, x + _ox, y - _ry + _oy, x + _rx + _ox + 1, y + _ry + _oy, _side_colour, id);
			}

			return _data_solid.touch_flags[_pid] == ENGINE_COLLISION_TOUCH_RIGHT;

		case SOLIDCOLLISION.ANY:
		
			if _do_debug && ds_list_find_index(_ds_list_side, id) == -1
			{
				ds_list_add(_ds_list_side, x - _rx + _ox - 1, y - _ry + _oy - 1, x + _rx + _ox + 1, y + _ry + _oy + 1, _side_colour, id);
			}

			return _data_solid.touch_flags[_pid] != ENGINE_COLLISION_TOUCH_NONE;
	}
}
