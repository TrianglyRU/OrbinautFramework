enum CULL_ACTION
{
	NONE,
	PAUSE,
	RESET,
	DESTROY
}

/// @self
/// @description							Creates a culler instance for this object.
/// @param {Enum.CULL_ACTION} _action		The culling action to be applied to the instance.
/// @param {Id.Instance} [_inst_id]			The instance the culler operates on (default is the calling instance).
function event_culler(_action, _inst_id = id)
{
	new ConstCuller(_action, _inst_id);
}

function ConstCuller(_action, _inst_id) constructor
{
	if _inst_id.culler != noone
	{
		return;
	}
	
	inst_id = _inst_id;
	inst_id.culler = self;
	
	sprite_index_start = inst_id.sprite_index;
	image_xscale_start = inst_id.image_xscale;
	image_yscale_start = inst_id.image_yscale;
	image_index_start = inst_id.image_index;
	depth_start = inst_id.depth;
	visible_start = inst_id.visible;
	
	reset_on_load = false;
	action = _action;
	
	/// @function run()
	run = function()
	{
		if action == CULL_ACTION.NONE
		{
			return;
		}
		
		if reset_on_load
		{
			reset_on_load = false;
			inst_id.image_xscale = image_xscale_start;
			inst_id.image_yscale = image_yscale_start;
			inst_id.image_index = image_index_start;
			inst_id.sprite_index = sprite_index_start;
			inst_id.visible = visible_start;
			inst_id.depth = depth_start;
			
			with inst_id
			{
				event_perform(ev_create, 0);
			}
			
			return;
		}
		
		FOR_EACH_CAMERA 
		{
			var _camera_data = view_data[_c];
	
			if _camera_data == undefined
			{
				continue;
			}
			
			var _w = camera_get_culling_width(_c);
			var _h = camera_get_culling_height(_c);
			
			var _left = _camera_data.coarse_x;
			var _right = _camera_data.coarse_x + _w;
			var _top = _camera_data.coarse_y;
			var _bottom = _camera_data.coarse_y + _h;
			
			var _x = floor(inst_id.x);
			var _y = floor(inst_id.y);
					
			switch action
			{
				case CULL_ACTION.DESTROY:
					
					var _dist_y = _y - camera_get_y(_c) + CULLING_ROUND_VALUE;
			
					if _x >= _left && _x < _right && _dist_y >= 0 && _dist_y < _h && _y < _camera_data.bottom_bound
					{
						// No action
						return;
					}
			
				break;
				
				case CULL_ACTION.PAUSE:
				case CULL_ACTION.RESET:
					
					if _x >= _left && _x < _right || inst_id.xstart >= _left && inst_id.xstart < _right
					{
						// No action
						return;
					}
			
				break;
			}
		}

		switch action
		{
			case CULL_ACTION.DESTROY:
				instance_destroy(inst_id);
			break;
		
			case CULL_ACTION.PAUSE:
				instance_deactivate_object(inst_id);
			break;
	
			case CULL_ACTION.RESET:
			
				reset_on_load = true;
				inst_id.x = inst_id.xstart;
				inst_id.y = inst_id.ystart;
				
				with inst_id
				{
					event_perform(ev_destroy, 0);
				}
				
				instance_deactivate_object(inst_id);
		
			break;
		}
	}
}