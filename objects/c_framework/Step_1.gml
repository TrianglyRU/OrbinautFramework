#region DEBUG

if global.dev_mode
{
	var _key_collision = ord("1");
	var _key_game_speed = ord("2");
	var _key_restart_room = ord("9"); 
	var _key_restart_game = ord("0");
	var _key_profiler = vk_f1;
	var _key_console = vk_f2;
	var _key_devmenu = vk_escape;
	
	if !is_keyboard_used_debug_overlay()
	{
		if keyboard_check_pressed(_key_collision)
		{
		    if ++global.debug_collision > 3
		    {
		        global.debug_collision = 0;
		    }
		}
		else if keyboard_check_pressed(_key_game_speed)
		{
		    if game_get_speed(gamespeed_fps) != 2
		    {
		        game_set_speed(2, gamespeed_fps);
		    }
		    else
		    {
		        game_set_speed(60, gamespeed_fps);
		    }
		}
		else if keyboard_check_pressed(_key_restart_room)
		{
		    room_restart();
		}
		else if keyboard_check_pressed(_key_restart_game)
		{
		    game_restart();
		}
		else if keyboard_check_pressed(_key_devmenu)
		{
		    room_goto(rm_devmenu);
		}
		else if keyboard_check_pressed(_key_profiler)
		{
			show_debug_overlay(!is_debug_overlay_open());
		}
		else if keyboard_check_pressed(_key_console)
		{
			show_debug_log(!is_debug_overlay_open());
		}
	}
}

#endregion

#region INPUT

var _act1a = ord("A"), _act1b = ord("Z");
var _act2a = ord("S"), _act2b = ord("X");
var _act3a = ord("D"), _act3b = ord("C");

var _input = input;
var _pads_array = _input.pads_array;
var _vibration = _input.vibration;
var _system_device_count = _input.system_device_count;
var _pads_registered = 0;

for (var i = 0; i < _system_device_count; i++)
{
	if !gamepad_is_connected(i) 
	{
	    continue;
	}

	_pads_array[_pads_registered] = i;

	if ++_pads_registered == ENGINE_INPUT_MAX_DEVICE_COUNT
	{
	    break;
	}
}

for (var i = 0; i < ENGINE_INPUT_MAX_DEVICE_COUNT; i++)
{
	if is_keyboard_used_debug_overlay()
	{
		break;
	}	
		
	var _press = input_get_pressed(i);
	var _down = input_get(i);
	
	// Process input for each registered gamepad
	if i < _pads_registered
	{
	    var _pad_id = _pads_array[i];
		
	    if _vibration[i] >= 0
	    {
			if _vibration[i] == 0
			{
				gamepad_set_vibration(_pad_id, 0, 0);
			}
			
			_vibration[i]--;
	    }

	    var _lv_value = gamepad_axis_value(_pad_id, gp_axislv);
	    var _lh_value = gamepad_axis_value(_pad_id, gp_axislh);

	    _press.up = gamepad_button_check_pressed(_pad_id, gp_padu) || (_lv_value < 0 && !_down.up);
	    _press.down = gamepad_button_check_pressed(_pad_id, gp_padd) || (_lv_value > 0 && !_down.down);
	    _press.left = gamepad_button_check_pressed(_pad_id, gp_padl) || (_lh_value < 0 && !_down.left);
	    _press.right = gamepad_button_check_pressed(_pad_id, gp_padr) || (_lh_value > 0 && !_down.right);
	    _press.start = gamepad_button_check_pressed(_pad_id, gp_start);
	    _press.action1 = gamepad_button_check_pressed(_pad_id, gp_face1);
	    _press.action2 = gamepad_button_check_pressed(_pad_id, gp_face2);
	    _press.action3 = gamepad_button_check_pressed(_pad_id, gp_face4);

	    _down.up = gamepad_button_check(_pad_id, gp_padu) || _lv_value < 0;
	    _down.down = gamepad_button_check(_pad_id, gp_padd) || _lv_value > 0;
	    _down.left = gamepad_button_check(_pad_id, gp_padl) || _lh_value < 0;
	    _down.right = gamepad_button_check(_pad_id, gp_padr) || _lh_value > 0;
	    _down.start = gamepad_button_check(_pad_id, gp_start);
	    _down.action1 = gamepad_button_check(_pad_id, gp_face1);
	    _down.action2 = gamepad_button_check(_pad_id, gp_face2);
	    _down.action3 = gamepad_button_check(_pad_id, gp_face4);
	} 
	else 
	{
		// Reset input states for unused pads
	    input_reset(_press);
	    input_reset(_down);
		
	    if i != 0 
	    {
	        continue;
	    }
	}
	
	// Handle keyboard input for the first input slot
	if i == 0 
	{
	    _press.up |= keyboard_check_pressed(vk_up);
	    _press.down |= keyboard_check_pressed(vk_down);
	    _press.left |= keyboard_check_pressed(vk_left);
	    _press.right |= keyboard_check_pressed(vk_right);
	    _press.start |= keyboard_check_pressed(vk_enter);
	    _press.action1 |= keyboard_check_pressed(_act1a) || keyboard_check_pressed(_act1b);
	    _press.action2 |= keyboard_check_pressed(_act2a) || keyboard_check_pressed(_act2b);
	    _press.action3 |= keyboard_check_pressed(_act3a) || keyboard_check_pressed(_act3b);

	    _down.up |= keyboard_check(vk_up);
	    _down.down |= keyboard_check(vk_down);
	    _down.left |= keyboard_check(vk_left);
	    _down.right |= keyboard_check(vk_right);
	    _down.start |= keyboard_check(vk_enter);
	    _down.action1 |= keyboard_check(_act1a) || keyboard_check(_act1b);
	    _down.action2 |= keyboard_check(_act2a) || keyboard_check(_act2b);
	    _down.action3 |= keyboard_check(_act3a) || keyboard_check(_act3b);
	}

	_down.action_any = _down.action1 || _down.action2 || _down.action3;
	_press.action_any = _press.action1 || _press.action2 || _press.action3;
	
	// Handle simultaneous input conflicts
	if _down.left && _down.right
	{
	    _down.left = false;
	    _down.right = false;
	    _press.left = false;
	    _press.right = false;
	}

	if _down.up && _down.down
	{
	    _down.up = false;
	    _down.down = false;
	    _press.up = false;
	    _press.down = false;
	}
}

#endregion

#region FADE

var _fade = fade;

if _fade.timer >= 0 && _fade.timer < ENGINE_FADE_TIMER_MAX
{
	_fade.state = _fade.timer == 0 ? FADESTATE.PLAINCOLOUR : FADESTATE.ACTIVE;
} 
else if _fade.state != FADESTATE.NONE
{
	if _fade.game_control
	{
	    state = STATE_NORMAL;
	}

	_fade.state = FADESTATE.NONE;
}

if _fade.process_flag == ENGINE_FADE_FLAG_UPDATE 
{
	if _fade.game_control 
	{
	    state = STATE_PAUSED;
	}

	if ++_fade.frequency_timer == _fade.frequency_target
	{
	    _fade.frequency_timer = 0;

	    if _fade.routine == FADEROUTINE.IN && _fade.timer < ENGINE_FADE_TIMER_MAX 
	    {
	        _fade.timer += _fade.timer_step;

	        if _fade.timer >= ENGINE_FADE_TIMER_MAX 
	        {
	            _fade.timer = ENGINE_FADE_TIMER_MAX;
	            _fade.process_flag = ENGINE_FADE_FLAG_IDLE;
	        }
	    } 
	    else if _fade.routine == FADEROUTINE.OUT && _fade.timer > 0
	    {
	        _fade.timer -= _fade.timer_step;

	        if _fade.timer <= 0 
	        {
	            _fade.timer = 0;
	            _fade.process_flag = ENGINE_FADE_FLAG_IDLE;
	        }
	    }
	}
}

#endregion

#region PAUSE & FRAME COUNTER

if state != STATE_PAUSED
{
	if allow_pause && input_get_pressed(0).start 
	{
	    instance_create_depth(0, 0, RENDERER_DEPTH_HUD, obj_gui_pause);
	} 
	else 
	{
	    frame_counter++;
	}
} 
else with obj_gui_pause
{
	event_perform(ev_other, ev_user0);
}

#endregion

#region OBJECT CULLING

if state != STATE_NORMAL
{
	var _ignored_behaviour = state == STATE_STOP_OBJECTS ? CULLING.PAUSEONLY : CULLING.NONE;
	var _list = ds_cull_list_pause;
	
	with c_object
	{
	    if data_culling.behaviour > _ignored_behaviour
		{
			ds_list_add(_list, id);				// Add objects to the ds_cull_list_pause list to let the engine draw them later
			instance_deactivate_object(id);
	    }
	}
}
else 
{
	// Reactivate the objects added to the ds_cull_list_pause list
	m_framework_activate_stopped_objects();
	
	// Activate objects within the camera's new culling region
	for (var i = 0; i < CAMERA_COUNT; i++)
	{
	    var _camera = camera_get_data(i);

	    if _camera == noone
		{
	        continue;
	    }
		
	    _camera.coarse_x = (camera_get_x(i) - ENGINE_CULLING_ROUND_VALUE) & -ENGINE_CULLING_ROUND_VALUE;
	    _camera.coarse_y = (camera_get_y(i) - ENGINE_CULLING_ROUND_VALUE) & -ENGINE_CULLING_ROUND_VALUE;
		
	    if _camera.coarse_x_last == _camera.coarse_x && _camera.coarse_y_last == _camera.coarse_y
		{
	        continue;
	    }
		
		_camera.coarse_x_last = _camera.coarse_x;
	    _camera.coarse_y_last = _camera.coarse_y;
		
		var _width =  camera_get_width(i) + ENGINE_CULLING_ROUND_VALUE + ENGINE_CULLING_ADD_WIDTH - 1;
		var _height = camera_get_height(i) + ENGINE_CULLING_ROUND_VALUE + ENGINE_CULLING_ADD_HEIGHT - 1;
		
	    instance_activate_region(_camera.coarse_x, _camera.coarse_y, _width, _height, true);
	}
	
	with c_object
	{
		// Since we're here, reset the interaction flag as well
	    data_interact.interact = true;
		
	    var _data_culling = data_culling;
	    var _behaviour = _data_culling.behaviour;
		
	    if _behaviour <= CULLING.ACTIVE 
		{
	        continue;
	    }
		
		// Were we just respawned?
		if _data_culling.respawn_flag
		{
		    image_xscale = _data_culling.scale_x;
		    image_yscale = _data_culling.scale_y;
		    image_index = _data_culling.img_index;
		    sprite_index = _data_culling.spr_index;
		    visible = _data_culling.is_visible;
		    depth = _data_culling.priority;
			
			event_perform(ev_create, 0);
		}
		
		var _cull_action = CULLING.NONE;

		for (var i = 0; i < CAMERA_COUNT; i++) 
		{
			var _camera = camera_get_data(i);
	
			if _camera == noone
			{
				continue;
			}
	
			// Clear flag
			_cull_action = CULLING.NONE;
			
			var _cull_width = camera_get_width(i) + ENGINE_CULLING_ADD_WIDTH + ENGINE_CULLING_ROUND_VALUE;
			var _cull_height = camera_get_height(i) + ENGINE_CULLING_ADD_HEIGHT + ENGINE_CULLING_ROUND_VALUE;
	
			switch _behaviour
			{
				case CULLING.DISABLE:
				case CULLING.RESPAWN:
				
					var _x = floor(x);
					
					if _x < _camera.coarse_x || _x >= _camera.coarse_x + _cull_width
					{
						if _behaviour == CULLING.DISABLE
						{
							_cull_action = _behaviour;
						}
						else if xstart >= _camera.coarse_x && xstart < _camera.coarse_x + _cull_width
						{
							// "Disappear"
							x = -128;
							y = -128;
							visible = false;
						}
						else
						{
							_cull_action = _behaviour;
						}
					}
		
				break;
		
				case CULLING.ORIGINDISABLE:
				case CULLING.ORIGINRESPAWN:
			
					if xstart < _camera.coarse_x || xstart >= _camera.coarse_x + _cull_width
					{
						_cull_action = _behaviour;
					}
		
				break;
		
				case CULLING.REMOVE:
				
					var _x = floor(x);
					var _y = floor(y);
					var _dist_y = _y - camera_get_y(i) + ENGINE_CULLING_ROUND_VALUE;
					
					if _y >= _camera.max_y
					{
						_cull_action = _behaviour;
						break;
					}
					
					if _x < _camera.coarse_x || _x >= _camera.coarse_x + _cull_width || _dist_y < 0 || _dist_y >= _cull_height
					{
						_cull_action = _behaviour;
					}
		
				break;
			}
			
			// If no flag has been set, do not check next camera
			if _cull_action == CULLING.NONE
			{
				break;
			}
		}
		
		// Has flag been set?
		if _cull_action != CULLING.NONE
		{
			if _cull_action != CULLING.REMOVE
			{
				// Trigger Create Event next on respawn. Not using _data_culling here because in case
				// the object was respawned, it might be a new data_culling struct
				if _cull_action >= CULLING.RESPAWN
				{	
					x = xstart;
					y = ystart;
				
					data_culling.respawn_flag = true;
				}
			
				instance_deactivate_object(id);
			}
			else
			{
				instance_destroy();
			}
		}
	}
}

#endregion

#region INSTANCES ANIMATOR

if state != STATE_PAUSED
{
	with c_object
	{
	    var _data_ani = data_ani;

	    if _data_ani.timer == undefined || _data_ani.timer < 0
	    {
	        continue;
	    }
		
	    if _data_ani.sprite_previous != sprite_index
	    {
	        _data_ani.sprite_previous = sprite_index;
	    }

	    if _data_ani.timer == 0
	    {
	        _data_ani.timer = ani_get_duration();
	    }

	    if --_data_ani.timer != 0
	    {
	        continue;
	    }

	    var _order_length = array_length(_data_ani.order);
	    var _last_frame = _order_length > 0 ? _order_length - 1 : image_number - 1;
		
		// Stop the animation
	    if _data_ani.index == _last_frame && _data_ani.index == _data_ani.loopframe
	    {
	        _data_ani.timer = -4;
	        continue;
	    }

	    if _data_ani.index < _last_frame
	    {
	        _data_ani.index++;
	    }
	    else
	    {
	        _data_ani.index = _data_ani.loopframe;
	    }

	    _data_ani.timer = ani_get_duration();
	    image_index = _order_length > 0 ? _data_ani.order[_data_ani.index] : _data_ani.index;
	}
}

#endregion

#region PALETTE

var _palette = palette;

if state != STATE_PAUSED
{
	var _ds_colours = _palette.ds_colours;
	var _ds_size = ds_list_size(_ds_colours);
	var _timer = _palette.timer;
	var _index = _palette.index;

	for (var i = 0; i < _ds_size; i++)
	{
	    var _col_id = _ds_colours[| i];
	    var _duration = _palette.duration[_col_id];

	    if _duration <= 0
	    {
	        continue;
	    }

	    if --_timer[_col_id] <= 0
	    {
	        if ++_index[_col_id] > _palette.end_index[_col_id]
	        {
	            _index[_col_id] = _palette.loop_index[_col_id];
	        }

	        _timer[_col_id] = _duration;
	    }
	}

	ds_list_clear(_ds_colours);
}

#endregion

with obj_player
{
	event_perform(ev_other, ev_user0);
}