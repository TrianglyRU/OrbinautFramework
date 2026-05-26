/// @self obj_player
function scr_player_cpu()
{
	if player_index == 0
	{
	    return;
	}
	
	var _jump_freq = 64;
	var _cpu_behaviour = global.cpu_behaviour;
	var _delay = PARAM_CPU_DELAY * player_index;
	var _can_receive_input = player_index < INPUT_SLOT_COUNT;
	
	if _can_receive_input
	{
	    if input_press_action_any() || input_press.up || input_press.down || input_press.left || input_press.right
	    {
	        cpu_control_timer = 600;
	    }
	}
	
	cpu_target = player_get(0);

	switch cpu_state
	{
	    case CPU_STATE.RESPAWN_INIT:
			
	        if _can_receive_input && !input_down_action_any() && !input_down.start
	        {
				if obj_game.frame_counter % 64 != 0 || cpu_target.state >= PLAYER_STATE.NO_INTERACT
				{
					break;
				}
	        }
			
	        x = cpu_target.x;
	        y = cpu_target.y - camera_get_height(cpu_target.camera_data.index) + 32;
			visible = true;
	        cpu_state = CPU_STATE.RESPAWN;
			
			if camera_data.index == player_index
			{
				camera_data.allow_updates = true;
			}
			
	    break;

	    case CPU_STATE.RESPAWN:
			
	        if _start_respawn()
	        {
	            break;
	        }
			
	        switch player_type
	        {
	            case PLAYER.SONIC:
	            case PLAYER.AMY:
	                animation = ANIM.SPIN;
	            break;
				
	            case PLAYER.TAILS:
					
	                animation = is_underwater ? ANIM.SWIM : ANIM.FLY;
	                play_tails_sound();
					
	            break;

	            case PLAYER.KNUCKLES:
	                animation = ANIM.GLIDE_AIR;
	            break;
	        }
			
	        var _follow_data = cpu_target.recorded_data[| _delay];
			
			if _follow_data == undefined
			{
				break;
			}
			
	        var _target_x = _follow_data[2];
	        var _target_y = _follow_data[3];
			
	        if _cpu_behaviour == CPU_BEHAVIOUR.S2 && instance_exists(obj_water)
	        {
	            _target_y = min(obj_water.y - 16, _target_y);
	        }
			
	        var _dist_x = floor(x) - _target_x;
			var _dist_y = floor(y) - _target_y;
			
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
					
	                facing = -1;
	            }
	            else
	            {
	                _dist_x *= -1;
					
	                if _vel_x >= _dist_x
	                {
	                    _vel_x = _dist_x;
	                    _dist_x = 0;
	                }
					
	                facing = 1;
	            }
				
	            x += _vel_x;
	        } 
			
	        if _dist_y != 0
	        {
	            y -= sign(_dist_y);
	        }
			
	        if _cpu_behaviour == CPU_BEHAVIOUR.S3 && (obj_game.state != GAME_STATE.NORMAL || cpu_target.state == PLAYER_STATE.DEATH)
	        {
	            break;
	        }
			
	        if _dist_x == 0 && _dist_y == 0
	        {
	            cpu_state = CPU_STATE.MAIN;
	            animation = ANIM.MOVE;
	            state = PLAYER_STATE.DEFAULT;
				secondary_layer = cpu_target.secondary_layer;
	        }
			
	    break;

	    case CPU_STATE.MAIN:
			
			depth = cpu_target.depth + player_index;
			
	        if cpu_target.state == PLAYER_STATE.DEATH
	        {
	            state = PLAYER_STATE.NO_INTERACT;
	            cpu_state = CPU_STATE.RESPAWN;
	            reset_substate();
				
	            break;
	        }
			
	        if _start_respawn()
	        {
	            break;
	        }
			
			if state >= PLAYER_STATE.FROZEN
			{
				break;
			}
			
	        if carry_target != noone || action == ACTION.CARRIED
	        {
	            break;
	        }
			
	        if cpu_control_timer > 0
	        {
	            cpu_control_timer--;
				
	            if !input_lock_control
	            {
	                break;
	            }
	        }
			
	        var _follow_data = cpu_target.recorded_data[| _delay];
			
			if _follow_data == undefined
			{
				break;
			}
			
	        var _target_input_press = input_copy(_follow_data[0]);
	        var _target_input_down = input_copy(_follow_data[1]);
	        var _target_x = _follow_data[2];
	        var _target_y = _follow_data[3];
	        var _target_push_flag = _follow_data[4];
	        var _target_facing = _follow_data[5];
			
	        if ground_lock_timer != 0 && spd == 0
	        {
	            cpu_state = CPU_STATE.STUCK;
	        }
			
	        if _cpu_behaviour == CPU_BEHAVIOUR.S3 && abs(cpu_target.spd) < 4 && cpu_target.on_object == noone
	        {
	            _target_x -= 32;
	        }
			
	        var _do_auto_jump = true;
			
	        if set_push_anim_by == noone || _target_push_flag != noone
	        {   
	            var _dist_x = _target_x - floor(x);
				
	            if _dist_x != 0
	            {
	                var _max_dist_x = _cpu_behaviour == CPU_BEHAVIOUR.S3 ? 48 : 16;
					
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
	                else if _dist_x < -_max_dist_x
	                {
	                    _target_input_down.left = true;
	                    _target_input_press.left = true;
	                    _target_input_down.right = false;
	                    _target_input_press.right = false;
	                }
					
	                var _dist_sign = sign(_dist_x);
					
	                if spd != 0 && sign(facing) == _dist_sign
	                {
	                    x += _dist_sign;
	                }
	            }
	            else
	            {
	                facing = _target_facing;
	            }

	            if !cpu_auto_jump
	            {	
	                if _dist_x >= 64 && obj_game.frame_counter % (_jump_freq * 4) != 0 || _target_y - floor(y) > -32
	                {
	                    _do_auto_jump = false;  
	                }
	            }
	            else
	            {
	                _target_input_down.action1 = true;
	                _target_input_down.action2 = true;
	                _target_input_down.action3 = true;
					
	                if is_grounded
	                {
	                    cpu_auto_jump = false;
	                }
	                else
	                {
	                    _do_auto_jump = false;
	                }
	            }
	        }
			
			_do_auto_jump &= animation != ANIM.DUCK;
			_do_auto_jump &= cpu_target.animation != ANIM.WAIT;
			_do_auto_jump &= obj_game.frame_counter % _jump_freq == 0;
			
	        if _do_auto_jump
	        {
	            _target_input_press.action1 = true;           
				_target_input_press.action2 = true;
				_target_input_press.action3 = true;
	            _target_input_down.action1 = true;
	            _target_input_down.action2 = true;
				_target_input_down.action3 = true;
				
	            cpu_auto_jump = true;
	        }
			
	        input_press = _target_input_press;
	        input_down = _target_input_down;
			
	    break;

	    case CPU_STATE.STUCK:
		
	        if _start_respawn()
	        {
	            break;
	        }

	        if ground_lock_timer != 0 || cpu_control_timer != 0 || spd != 0
	        {
	            break;
	        }

	        if animation == ANIM.IDLE
	        {
	            if floor(cpu_target.x) >= floor(x)
	            {
	                facing = 1;
	            }
	            else
	            {
	                facing = -1;
	            }
	        }

	        input_down.down = true;
			
			if obj_game.frame_counter % 128 == 0
			{
				input_down.down = false;
				input_press.action1 = false;
				input_press.action2 = false;
				input_press.action3 = false;
				cpu_state = CPU_STATE.MAIN;
			}
			else if obj_game.frame_counter % 32 == 0
			{
				input_press.action1 = true;
				input_press.action2 = true;
				input_press.action3 = true;
			}
			
	    break;  
	}
}

/// @self scr_player_cpu
function _start_respawn()
{
	gml_pragma("forceinline");
	
	if instance_is_drawn() || x >= camera_data.right_bound
	{
	    cpu_timer_respawn = 0; return false;
	}
	
	if ++cpu_timer_respawn >= 300 || on_object != noone && !instance_exists(on_object)
	{
	    respawn(); return true;
	}

	return false;
}