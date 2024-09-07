/// @function scr_player_cpu
function scr_player_cpu()
{
	gml_pragma("forceinline");

	if player_index == 0
	{
	    exit;
	}

	/// @method m_local_should_respawn
	var m_local_should_respawn = function()
	{
	    if obj_is_visible() || x >= camera_data.max_x
	    {
	        cpu_timer_respawn = 0;
	        return false;
	    }
		
	    if ++cpu_timer_respawn >= 300 || on_object != noone && !instance_exists(on_object)
	    {
	        m_player_respawn();
	        return true;
	    }

	    return false;
	}

	var JUMP_FREQUENCY = 64;
	
	var _cpu_behaviour = global.cpu_behaviour;
	var _delay = PARAM_CPU_DELAY * player_index;
	
	cpu_target = player_get(0);
	
	// Disable CPU logic for 10 seconds if received any input
	var _can_receive_input = player_index < ENGINE_INPUT_MAX_DEVICE_COUNT;

	if _can_receive_input
	{
	    if input_down.action_any || input_down.up || input_down.down || input_down.left || input_down.right
	    {
	        cpu_timer_input = 600;
	    }
	}

	switch cpu_state
	{
	    case CPU_STATE_RESPAWN_INIT:
			
			if cpu_target.state == PLAYER_STATE_DEATH
			{
				break;
			}
			
	        // If can receive input, take up to 64 steps to respawn if no input is detected
	        if _can_receive_input && !(input_down.action_any || input_down.start) && c_framework.frame_counter % 64 != 0
	        {
	            break;
	        }
			
	        x = cpu_target.x;
	        y = cpu_target.y - camera_get_height(cpu_target.camera_data.index) + 32;
	        cpu_state = CPU_STATE_RESPAWN;
			
			if (camera_data.index == player_index)
			{
				camera_data.allow_movement = true;
			}
			
	    break;

	    case CPU_STATE_RESPAWN:
		
	        // Exit if respawned
	        if m_local_should_respawn()
	        {
	            break;
	        }

	        switch PlayerType
	        {
	            case PLAYER_SONIC:
	            case PLAYER_AMY:
	                animation = ANI_SPIN;
	            break;

	            case PLAYER_TAILS:
	                animation = is_underwater ? ANI_SWIM : ANI_FLY;
	                m_player_play_tails_sound();
	            break;

	            case PLAYER_KNUCKLES:
	                animation = ANI_GLIDE_AIR;
	            break;
	        }
			
			// Retrieve follow data
	        var _follow_data = cpu_target.ds_record_data[| _delay];
	        var _target_x = _follow_data[2];
	        var _target_y = _follow_data[3];
			
			// Fly above the water surface if the followed player is near or below it
	        if _cpu_behaviour == CPU_BEHAVIOUR_S2 && instance_exists(c_stage) && c_stage.water_enabled
	        {
	            _target_y = min(c_stage.water_level - 16, _target_y);
	        }

	        // Move towards target x position
	        var _dist_x = floor(x) - _target_x;
	        if _dist_x != 0
	        {
	            var _vel_x = abs(cpu_target.vel_x) + min(floor(abs(_dist_x) / 16), 12) + 1;	
	            if _dist_x >= 0
	            {
	                if _vel_x < _dist_x
	                {
	                    _vel_x *= -1;
	                }
	                else
	                {
	                    _vel_x = -_dist_x;
	                    _dist_x = 0;
	                }
					
	                facing = DIRECTION.NEGATIVE;
	            }
	            else
	            {
	                _dist_x *= -1;
					
	                if _vel_x >= _dist_x
	                {
	                    _vel_x = _dist_x;
	                    _dist_x = 0;
	                }
					
	                facing = DIRECTION.POSITIVE;
	            }
				
	            x += _vel_x;
	        }

	        // Move towards target y position
	        var _dist_y = _target_y - floor(y);
	        if _dist_y != 0
	        {
	            y += sign(_dist_y);
	        }
			
			// Do not land if the followed player is dead (S3 and onwards)        
	        if _cpu_behaviour == CPU_BEHAVIOUR_S3 && (c_framework.state != STATE_NORMAL || cpu_target.state == PLAYER_STATE_DEATH)
	        {
	            break;
	        }
			
			// Check if reached target position
	        if _dist_x == 0 && _dist_y == 0
	        {
	            cpu_state = CPU_STATE_MAIN;
	            animation = ANI_MOVE;
	            state = PLAYER_STATE_CONTROL;
	        }
			
	    break;

	    case CPU_STATE_MAIN:
			
			// Display behind the followed player
			depth = cpu_target.depth + player_index;
			
	        if cpu_target.state == PLAYER_STATE_DEATH
	        {
	            state = PLAYER_STATE_NO_CONTROL;
	            cpu_state = CPU_STATE_RESPAWN;
				
	            m_player_reset();
	            break;
	        }
			
			// Exit if respawned
	        if m_local_should_respawn()
	        {
	            break;
	        }

	        if carry_target != noone || action == ACTION_CARRIED || state == PLAYER_STATE_NO_CONTROL
	        {
	            break;
	        }
			
			// Exit if CPU logic is disabled
	        if cpu_timer_input > 0
	        {
	            cpu_timer_input--;
				
	            if !input_no_control
	            {
	                break;
	            }
	        }
			
			// Retrieve follow data
	        var _follow_data = cpu_target.ds_record_data[| _delay];
	        var _target_input_press = struct_copy(_follow_data[0]);
	        var _target_input_down = struct_copy(_follow_data[1]);
	        var _target_x = _follow_data[2];
	        var _target_y = _follow_data[3];
	        var _target_push_flag = _follow_data[4];
	        var _target_facing = _follow_data[5];
			
	        if ground_lock_timer != 0 && spd_ground == 0
	        {
	            cpu_state = CPU_STATE_STUCK;
	        }
			
			// Adjust target x position by 32px
	        if _cpu_behaviour == CPU_BEHAVIOUR_S3 && abs(cpu_target.spd_ground) < 4 && cpu_target.on_object == noone
	        {
	            _target_x -= 32;
	        }
			
	        var _do_jump = true;
			
			// Copy and modify inputs if we are not pushing anything or if the followed
			// player was pushing something a few frames ago
	        if set_push_anim_by == noone || _target_push_flag != noone
	        {   
	            var _dist_x = _target_x - floor(x);
	            if _dist_x != 0
	            {
	                var _max_dist_x = _cpu_behaviour == CPU_BEHAVIOUR_S3 ? 48 : 16;
					
					// Go right
	                if _dist_x > 0
	                {
	                    if _dist_x > _max_dist_x
	                    {
	                        _target_input_down.left = false;
	                        _target_input_press.left = false;
	                        _target_input_down.right = true;
	                        _target_input_press.right = true;
	                    }
	                }
					
					// Go left
	                else if _dist_x < -_max_dist_x
	                {
	                    _target_input_down.left = true;
	                    _target_input_press.left = true;
	                    _target_input_down.right = false;
	                    _target_input_press.right = false;
	                }
					
	                var _dist_sign = sign(_dist_x);
					
	                if spd_ground != 0 && sign(facing) == _dist_sign
	                {
	                    x += _dist_sign;
	                }
	            }
	            else
	            {
	                facing = _target_facing;
	            }

	            if !cpu_jump_flag
	            {	
					// Cancel jump if too far away nor the followed player is way above us
	                if _dist_x >= 64 && c_framework.frame_counter % (JUMP_FREQUENCY * 4) != 0 || _target_y - floor(y) > -32
	                {
	                    _do_jump = false;  
	                }
	            }
	            else
	            {
	                _target_input_down.action_any = true;
					
	                if is_grounded
	                {
	                    cpu_jump_flag = false;
	                }
	                else
	                {
	                    _do_jump = false;
	                }
	            }
	        }

	        // Determine if a jump should be performed
	        if _do_jump && animation != ANI_DUCK && cpu_target.animation != ANI_WAIT && c_framework.frame_counter % JUMP_FREQUENCY == 0
	        {
	            _target_input_press.action_any = true;
	            _target_input_down.action_any = true;
	            cpu_jump_flag = true;
	        }
			
			// Apply new input
	        input_press = _target_input_press;
	        input_down = _target_input_down;
			
	    break;

	    case CPU_STATE_STUCK:
		
	        // Exit if respawned
	        if m_local_should_respawn()
	        {
	            break;
	        }

	        if ground_lock_timer != 0 || cpu_timer_input != 0 || spd_ground != 0
	        {
	            break;
	        }

	        if animation == ANI_IDLE
	        {
	            if floor(cpu_target.x) >= floor(x)
	            {
	                facing = DIRECTION.POSITIVE;
	            }
	            else
	            {
	                facing = DIRECTION.NEGATIVE;
	            }
	        }

	        input_down.down = true;
			
			// Release Spin Dash after (up to) 128 steps
			if c_framework.frame_counter % 128 == 0
			{
				input_down.down = false;
				input_press.action_any = false;
				cpu_state = CPU_STATE_MAIN;
			}
			
			// Charge Spin Dash every (up to) 32 steps
			else if c_framework.frame_counter % 32 == 0
			{
				input_press.action_any = true;
			}
			
	    break;  
	}
}