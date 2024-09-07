/// @self c_object
/// @description Handles collision detection and response between the player and a solid object.
/// @param {Id.Instance} player The player object instance.
/// @param {Enum.SOLIDOBJECT} type The type of solid object.
/// @param {Enum.SOLIDATTACH} [attach_type] Whether the player is allowed to land on this object or should they be reset (optional, defaults to DEFAULT).
function obj_act_solid(_player, _type, _attach_type = SOLIDATTACH.DEFAULT)
{
	/// @method m_local_attach
	var m_local_attach = function(_player, _obj, _attach_type, _distance)
	{
		if _attach_type == SOLIDATTACH.NONE
		{
			exit;
		}
		
		if _attach_type == SOLIDATTACH.RESET_PLAYER
		{
			_player.m_player_reset();
		}
		
		_player.y -= _distance + 1;
		_player.spd_ground	= _player.vel_x;
		_player.vel_y = 0;
		_player.angle = 0;
		_player.on_object = _obj;
		
		if !_player.is_grounded
		{
			_player.m_player_land();
		}
	}
	
	var _pid = _player.player_index;
	var _solid = data_solid;
	
	// Setup initial collision parameters
	_solid.touch_flags[_pid] = ENGINE_COLLISION_TOUCH_NONE;
	_solid.push_flags[_pid] = false;

	var _pw = _player.data_solid.radius_x;
	var _ph = _player.data_solid.radius_y;
	var _obj_w = _solid.radius_x;
	var _obj_h = _solid.radius_y;
	
	if  _obj_w <= 0 || _obj_h <= 0 || _pw <= 0 || _ph <= 0 || _player.state >= PLAYER_STATE_NO_CONTROL
	{
		exit;
	}
	
	var _px = floor(_player.x);
	var _py = floor(_player.y);
	var _obj_x_prev = floor(xprevious) + _solid.offset_x;
	var _obj_x = floor(x) + _solid.offset_x;
	var _obj_y = floor(y) + _solid.offset_y;
	var _obj_hmap = _solid.height_map;
	var _combined_width  = _obj_w + _pw + 1;
	var _combined_height = _obj_h + _ph;
	var _slope_offset = 0;
	var _grip_y = 4;
	var _ext_x = 0;
	var _ext_y = 0;

	// Handle height map for slope adjustment
	if array_length(_obj_hmap) > 0
	{
		var _index;
		if image_xscale >= 0
		{
			_index = _px - _obj_x + _obj_w;
		}
		else
		{
			_index = _obj_x - _px + _obj_w;
		}
		
		_index = clamp(_index, 0, array_length(_obj_hmap) - 1);
		_slope_offset = (_obj_h - _obj_hmap[_index]) * image_yscale;	
	}

	// Extend the radiuses for better & fair solid collision (if enabled)
	if global.better_solid_collision
	{
		_ext_x = _pw;
		_ext_y = _grip_y;
	}
	
	// Visualise collision if debugging
	if global.debug_collision == 3
	{
		var _ds_list = c_framework.collision.ds_solid_size;
		var _solid_colour = $00FFFF;
		
		if ds_list_find_index(_ds_list, _player) == -1
		{
			ds_list_add(_ds_list, _px - _pw, _py - _ph, _px + _pw, _py + _ph, _solid_colour, _player);
		}
		
		if ds_list_find_index(_ds_list, id) == -1
		{
			ds_list_add(_ds_list, _obj_x - _obj_w, _obj_y - _obj_h + _slope_offset, _obj_x + _obj_w, _obj_y + _obj_h + _slope_offset, _solid_colour, id);
		}
	}

	// Handle collision with the object if player is already on it
	if _player.on_object == id
	{	
		_solid.touch_flags[_pid] = ENGINE_COLLISION_TOUCH_TOP;
		_player.x += _obj_x - _obj_x_prev;
		_player.y = _obj_y - _obj_h + _slope_offset - _ph - 1;
		_px = floor(_player.x);
		
		if _type != SOLIDOBJECT.TOP
		{
			var _relative_x = _px - _obj_x + _combined_width;
			
			if _relative_x > 0 && _relative_x < _combined_width * 2
			{
				exit;
			}
		}
		else
		{
			var _relative_x = _px - _obj_x + _obj_w;
			
			if _relative_x >= -_ext_x && _relative_x <= _obj_w * 2 + _ext_x
			{
				exit;
			}
		}
		
		_solid.touch_flags[_pid] = ENGINE_COLLISION_TOUCH_NONE;
		_player.on_object = noone;
		
		exit;
	}
	
	// Handle collision detection for non-platform objects
	if _type != SOLIDOBJECT.TOP
	{
		var _s3_method = global.player_physics >= PHYSICS_S3;
		
		var _x_dist = _px - _obj_x + _combined_width;
		var _y_dist = _py - _obj_y + _combined_height - _slope_offset + _grip_y;
		
		if _x_dist < 0 || _x_dist > _combined_width * 2 || _y_dist < 0 || _y_dist > _combined_height * 2 + _ext_y
		{
			obj_clear_player_push(_player);
			exit;
		}
		
		// Check clipping
		var _x_clip = _px < _obj_x ? _x_dist : _x_dist - _combined_width * 2;
		var _y_clip = _py < _obj_y ? _y_dist : _y_dist - _combined_height * 2 - _grip_y;
			
		// VERTICAL COLLISION
		
		if abs(_x_clip) >= abs(_y_clip) || _s3_method && abs(_y_clip) <= 4
		{
			// Bottom collision
			if _y_clip < 0
			{
				if _type == SOLIDOBJECT.ITEMBOX || _type == SOLIDOBJECT.SIDES
				{
					// Fallthrough to horizontal collision
				}
				else if _player.vel_y == 0 && _player.is_grounded
				{
					if abs(_x_clip) >= 16
					{
						_player.m_player_kill();
						exit;
					}
					
					// If not crushed, fallthrough to horizontal collision
				}
				else 
				{
					if _player.vel_y < 0
					{
						if _s3_method && !_player.is_grounded
						{
							_player.spd_ground = 0;
						}
						
						_player.y -= _y_clip;
						_player.vel_y = 0;
					}
					
					_solid.touch_flags[_pid] = ENGINE_COLLISION_TOUCH_BOTTOM;
					
					// Do not run horizontal collision
					exit;							
				}
			}
			
			// Top collision
			else
			{
				if _y_clip < 16 && _type != SOLIDOBJECT.SIDES
				{
					if _player.vel_y >= 0
					{
						var _relative_x = _px - _obj_x + _obj_w;
						if _relative_x >= 0 - _ext_x && _relative_x <= _obj_w * 2 + _ext_x
						{
							_solid.touch_flags[_pid] = ENGINE_COLLISION_TOUCH_TOP;
							m_local_attach(_player, id, _attach_type, _y_clip - _grip_y);
						}
					}
				}
				else
				{
					obj_clear_player_push(_player);
				}
				
				// Do not run horizontal collision
				exit;	
			}
		}
		
		// HORIZONTAL COLLISION

		if !_s3_method && abs(_y_clip) <= 4
		{
			obj_clear_player_push(_player);
			exit;
		}

		_solid.touch_flags[_pid] = _px < _obj_x ? ENGINE_COLLISION_TOUCH_LEFT : ENGINE_COLLISION_TOUCH_RIGHT;
		
		if _player.is_grounded
		{
			_player.set_push_anim_by = id;
		}
		else
		{
			_player.set_push_anim_by = noone;
		}
		
		if _x_clip != 0 && sign(_x_clip) == sign(_player.vel_x)
		{
			_player.spd_ground = 0;
			_player.vel_x = 0;
			_solid.push_flags[_pid] = _player.is_grounded;
		}
		
		_player.x -= _x_clip;
	}
	
	// Handle collision detection for platform objects
	else if _player.vel_y >= 0
	{
		var _relative_x = _px - _obj_x + _obj_w;
		var _y_clip = _obj_y - _obj_h - _grip_y + _slope_offset - _py - _ph;
		
		if _relative_x < -_ext_x || _relative_x > _obj_w * 2 + _ext_x
		{
			exit;
		}
		
		if _y_clip < -16 || _y_clip >= 0
		{
			exit;
		}
		
		_solid.touch_flags[_pid] = ENGINE_COLLISION_TOUCH_TOP;
		m_local_attach(_player, id, _attach_type, -_y_clip - _grip_y);
	}
}