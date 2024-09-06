/// @function scr_player_input
function scr_player_input()
{
	gml_pragma("forceinline");

	// Handle replay data for button inputs
	var _replay_data_buttons = array_length(replay_data);

	if _replay_data_buttons > 0
	{
		var _inputs = array_create(_replay_data_buttons, false);	
		var _keys = variable_struct_get_names(input_down);

		for (var i = 0; i < _replay_data_buttons; i++)
		{
			var _key = _keys[i];
			var _button_timers = replay_data[i];
		
			if replay_button_state[i] < array_length(_button_timers)
			{
				if replay_button_timer[i] < 0
				{
					replay_button_timer[i] = _button_timers[0];
				}
			
				if replay_button_timer[i] > 0
				{
					replay_button_timer[i]--;
				}
				else if ++replay_button_state[i] < array_length(_button_timers)
				{
					replay_button_timer[i] = _button_timers[replay_button_state[i]];
				}
			
				_inputs[i] = replay_button_state[i] % 2;
			}
		
			input_press[$ _key] = _inputs[i] && !input_down[$ _key];			
			input_down[$ _key] = _inputs[i];
		}

		exit;
	}

	// Handle input control based on player index
	if input_no_control
	{
		exit;
	}

	if player_index < ENGINE_INPUT_MAX_DEVICE_COUNT
	{
		input_press = struct_copy(input_get_pressed(player_index));
		input_down = struct_copy(input_get(player_index));
	}
	else
	{
		input_reset(input_press);
		input_reset(input_down);
	}
}