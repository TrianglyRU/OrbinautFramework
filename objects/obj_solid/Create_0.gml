// Inherit the parent event
event_inherited();

enum SOLID_TYPE
{
	ITEM_BOX,
	SIDES,
	FULL,
	FULL_CLEAR_PLAYER,
	FULL_NO_LAND,
	TOP,
	TOP_CLEAR_PLAYER,
	TOP_NO_LAND
}

enum SOLID_TOUCH
{
    NONE,
	TOP,
	BOTTOM,
	LEFT,
	RIGHT
}

solid_object = function(_player, _type)
{
	var _p = _player.player_index;
	
	solid_touch[_p] = SOLID_TOUCH.NONE;
	solid_push[_p] = false;
	
	if _player.state >= PLAYER_STATE.NO_INTERACT
	{
		return;
	}
	
	var _vanilla_collision = !global.better_solid_collision;
	
	var _ox = floor(x);
	var _oy = floor(y);
	var _oleft = floor(bbox_left);
	var _otop = floor(bbox_top);
	var _oright = floor(bbox_right) - 1;
	var _obottom = floor(bbox_bottom) - 1;
	
	var _px = floor(_player.x);
	var _py = floor(_player.y);
	var _prx = _player.radius_wall;
	var _pry = _player.radius_y;
	var _pleft = _px - _prx;
	var _pright = _px + _prx - 1;
	var _ptop = _py - _pry;
	var _pbottom = _py + _pry - 1;
	
	var _grip_y = _type == SOLID_TYPE.ITEM_BOX ? 0 : 4;
	var _slope_offset = 0;
	
	// Get slope offset
	if array_length(solid_offsets) > 0
	{
		var _index;
		var _relative_x = _px - _oleft;
		
		if image_xscale >= 0
		{
			_index = _relative_x;
		}
		else
		{
			_index = _oright - _oleft - _relative_x;
		}
		
		_slope_offset = solid_offsets[clamp(_index, 0, array_length(solid_offsets) - 1)] * sign(image_yscale);
	}
	
	// Moving along the object
	if _player.on_object == id
	{
		_player.x += _ox - floor(xprevious);
		_player.y = _otop - _pry;
		
		// Apply slope_offset always in vanilla collision and only when the object is not flipped otherwise
		if _vanilla_collision || image_yscale >= 0
		{
			_player.y += _slope_offset;
		}
		
		var _new_px = floor(_player.x);
		var _new_pleft = _new_px - _prx;
		var _new_pright = _new_px + _prx - 1;
		
		if _type < SOLID_TYPE.TOP || !_vanilla_collision
		{
			if !_player.is_grounded || _new_pright < _oleft || _new_pleft > _oright
			{
				_player.on_object = noone;
			}
			else
			{
				solid_touch[_p] = SOLID_TOUCH.TOP;
			}
		}
		else
		{
			if !_player.is_grounded || _new_px < _oleft || _new_px > _oright
			{
				_player.on_object = noone;
			}
			else
			{
				solid_touch[_p] = SOLID_TOUCH.TOP;
			}
		}
		
		return;
	}
	
	// Colliding with the object
	var _ptop_off;
	var _pbottom_off;
	
	// Assume player is slope_offset px higher and grip_y px lower
	if _vanilla_collision
	{
		_ptop_off = _ptop - _slope_offset + _grip_y;
		_pbottom_off = _pbottom - _slope_offset + _grip_y;
	}
	
	// Assume their bottom is slope_offset px higher and grip_y px lower
	else if image_yscale >= 0
	{
		_ptop_off = _ptop;
		_pbottom_off = _pbottom - _slope_offset + _grip_y;
	}
	
	// Flipped: assume their top is slope_offset px lower, bottom is grip_y px lower
	else
	{
		_ptop_off = _ptop - _slope_offset;
		_pbottom_off = _pbottom + _grip_y;
	}
	
	// Skip slope_offset when landing on flipped object with improved collision
	if !_vanilla_collision && image_yscale < 0
	{
		_slope_offset = 0;
	}
	
	// Non-platform objects
	if _type < SOLID_TYPE.TOP
	{
		if !rectangle_in_rectangle(_pleft, _ptop_off, _pright, _pbottom_off, _oleft - 1, _otop, _oright + 1, _obottom)
		{
			_player.clear_solid_push_by(id); return;
		}
		
		var _x_clip = _px < _ox ? _pright - _oleft + 1 : _pleft - _oright - 1;
		var _y_clip;
		
		if _py < _oy
		{
			_y_clip = _pbottom_off - _otop + 1;
		}
		else
		{
			_y_clip = _ptop_off - _obottom - 1;
			
			// Subtract grip_y offset
			if _vanilla_collision
			{
				_y_clip -= _grip_y;
			}
		}
		
		var _can_collide_v = abs(_x_clip) >= abs(_y_clip);
		var _can_collide_h = abs(_y_clip) > _grip_y;
		
		// VERTICAL COLLISION
		
		// Regular
		if _type != SOLID_TYPE.ITEM_BOX
		{
			var _s3_method = global.player_physics >= PHYSICS.S3;
			
			if _s3_method
			{
				_can_collide_v |= !_can_collide_h;
				_can_collide_h = true;
			}
			
			if _can_collide_v
			{
				// From below
				if _y_clip < 0
				{
					if _type == SOLID_TYPE.SIDES
					{
						// Try horizontal collision
					}
					else if _player.vel_y == 0 && _player.is_grounded
					{
						if abs(_x_clip) >= 16
						{
							_player.kill(); return;
						}
					
						// If not crushed, try horizontal collision
					}
					else
					{
						if _player.vel_y < 0
						{
							if _s3_method && !_player.is_grounded
							{
								_player.spd = 0;
							}
						
							_player.y -= _y_clip;
							_player.vel_y = 0;
						}
					
						solid_touch[_p] = SOLID_TOUCH.BOTTOM;
						
						// Do not run horizontal collision
						return;							
					}
				}
				
				// From above
				else
				{
					if _y_clip < 16 && _type != SOLID_TYPE.SIDES
					{
						if _player.vel_y >= 0
						{
							if  _vanilla_collision && _px >= _oleft && _px <= _oright
							|| !_vanilla_collision && _pright >= _oleft && _pleft <= _oright
							{
								attach_player(_type, _player, _otop + _slope_offset);
							}
						}
					}
					else
					{
						_player.clear_solid_push_by(id);
					}
					
					// Do not run horizontal collision
					return;	
				}
			}
		}
		
		// Item Box
		else
		{
			if _y_clip < 16 && _px >= _oleft - 4 && _px <= _oright + 4
			{
				attach_player(_type, _player, _otop + _slope_offset);
				
				// Do not run horizontal collision
				return;
			}
			
			// Collide horizontally
			_can_collide_h = true;
		}
		
		// HORIZONTAL COLLISION
		
		if !_can_collide_h
		{
			_player.clear_solid_push_by(id); return;
		}
		
		solid_touch[_p] = _px < _ox ? SOLID_TOUCH.LEFT : SOLID_TOUCH.RIGHT;
		
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
			_player.spd = 0;
			_player.vel_x = 0;
			
			solid_push[_p] = _player.is_grounded;
		}
		
		_player.x -= _x_clip;
	}
	
	// Platform objects
	else if _player.vel_y >= 0
	{
		if  _vanilla_collision && _px >= _oleft && _px <= _oright
		|| !_vanilla_collision && _pright >= _oleft && _pleft <= _oright
		{
			var _y_clip = _otop - 1 - _pbottom_off;
			
			if _y_clip >= -16 && _y_clip <= 0
			{
				attach_player(_type, _player, _otop + _slope_offset);
			}
		}
	}
}

attach_player = function(_type, _player, _bbtop)
{
	solid_touch[_player.player_index] = SOLID_TOUCH.TOP;
	
	if _type == SOLID_TYPE.FULL_NO_LAND || _type == SOLID_TYPE.TOP_NO_LAND
	{
		return;
	}
	
	if _type == SOLID_TYPE.FULL_CLEAR_PLAYER || _type == SOLID_TYPE.TOP_CLEAR_PLAYER
	{
		_player.reset_substate();
	}
	
	_player.y = _bbtop - _player.radius_y;
	_player.spd	= _player.vel_x;
	_player.vel_y = 0;
	_player.angle = 0;
	_player.on_object = id;
	
	if !_player.is_grounded
	{
		_player.land();
	}
}

solid_offsets = [];
solid_balance = true;
solid_push = array_create(PLAYER_MAX_COUNT, false);
solid_touch = array_create(PLAYER_MAX_COUNT, SOLID_TOUCH.NONE);