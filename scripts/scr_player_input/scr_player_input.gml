/// @self obj_player
function scr_player_input()
{
	var _replay_data_buttons = array_length(replay_data);
	if _replay_data_buttons > 0
	{
		var _inputs = array_create(_replay_data_buttons, false);
		
		var _keys = variable_struct_get_names(input_down);
		
		for (var _i = 0; _i < _replay_data_buttons; _i++)
		{
			var _key = _keys[_i];
			var _button_timers = replay_data[_i];
			var _timers_total = array_length(_button_timers);
			
			if replay_button_state[_i] < _timers_total
			{
				if replay_button_timer[_i] < 0
				{
					replay_button_timer[_i] = _button_timers[0];
				}
			
				if replay_button_timer[_i] > 0
				{
					replay_button_timer[_i]--;
				}
				else if ++replay_button_state[_i] < _timers_total
				{
					replay_button_timer[_i] = _button_timers[replay_button_state[_i]];
				}
				
				_inputs[_i] = replay_button_state[_i] % 2;
			}
		
			input_press[$ _key] = _inputs[_i] && !input_down[$ _key];			
			input_down[$ _key] = _inputs[_i];
		}

		return;
	}
	
	if input_lock_control
	{
		return;
	}
	
	if player_index < INPUT_SLOT_COUNT
	{
		var _global_pressed = input_check_pressed(player_index);
		var _global_down = input_check(player_index);
		
		input_press = input_copy(_global_pressed);
		input_down = input_copy(_global_down);
	}
	else
	{
		input_reset(input_press);
		input_reset(input_down);
	}
}