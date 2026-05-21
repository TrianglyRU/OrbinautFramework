if obj_game.state != GAME_STATE.NORMAL
{
	return;
}

var _input_press = input_check_pressed(0);

if _input_press.down
{
	if ++option_id >= category_options_count
	{
		option_id = 0;
	}
}
else if _input_press.up
{
	if --option_id < 0
	{
		option_id = category_options_count - 1;
	}
}

if _input_press.action3 && category_id == 1 && option_id > 0
{	
	alter_option(option_id, "SAVE " + string(option_id - 1));
	game_delete_data(option_id - 1);
	
	return;
}

if _input_press.action2
{
	if category_id == 3
	{
		game_save_settings();
	}
	
	load_category(category_data[DEVM_PARENT_CATEGORY_ID]);
	
	return;
}

// Handle input based on the current category
switch category_id
{
	case 3:
		
		// For settings category, react only to left & right inputs
		if !_input_press.left && !_input_press.right
		{
			return;
		}
		
	break;
	
	default:
		
		// For everything else, react only to action1 and start inputs
		if !_input_press.action1 && !_input_press.start
		{
			return;
		}
}

// Handle actions for each menu category
switch category_id
{	
	// Main menu
	case 0:
	
		switch option_id
		{
			case 0:
			
				load_category(1);	
				
				for (var _i = 0; _i < 4; _i++)
				{
					var _check_result = game_check_data(_i);
					
					if _check_result != SAVE_DATA_STATE.EMPTY
					{
						alter_option(_i + 1, (_check_result == 2 ? "COMPLETED GAME " : "SAVED GAME ") + string(_i));		
					}
				}
				
			break;
			
			case 1:	
			
				if global.dev_mode
				{
					load_category(2);
				}
				else
				{
					audio_sfx_play(snd_fail);
				}	
				
			break;
			
			case 2:
			
				load_category(3);
				
				for (var _i = 0; _i < category_options_count; _i++)
		        {
		            alter_setting(_i);
		        }
		
			break;
			
			case 3:
				game_end();
			break;
		}
		
	break;
	
	// Start game
	case 1:
		
		global.current_save_slot = option_id - 1;
		
		var _new_game_stage = scr_menu_start_load_game();
		
		if _new_game_stage != undefined
		{
			global.game_progress_flag = 0;
			room_to_load = _new_game_stage;
			load_category(4);
		}
		
	break;
	
	// Room selection
	case 2:	
		
		room_to_load = rooms[option_id];
		
		if room_to_load < 0
		{
			audio_sfx_play(snd_fail);
		}
		else
		{
			global.current_save_slot = undefined;
			load_category(4);
		}
		
	break;
	
	// Settings menu
	case 3:	
	
		switch option_id
		{
			case 0:
			
				global.gamepad_rumble = !global.gamepad_rumble;
				
				if global.gamepad_rumble
				{
					input_set_rumble(0, 0.15, INPUT_RUMBLE_MEDIUM);
				}
				
			break;
			
			case 1:
			
				if _input_press.left && global.music_volume > 0
				{
					global.music_volume -= 0.1;
				}
				else if _input_press.right && global.music_volume < 1
				{
					global.music_volume += 0.1;
				}
				else
				{
					break;
				}

				audio_bgm_play(snd_bgm_act_clear);
				
			break;
			
			case 2:
				
				if _input_press.left && global.sound_volume > 0
				{
					global.sound_volume -= 0.1;
				}
				else if _input_press.right && global.sound_volume < 1
				{
					global.sound_volume += 0.1;
				}
				else
				{
					break;
				}
				
				audio_sfx_play_ring();
				
			break;
			
			case 3:
			
				if _input_press.left && global.window_scale > 1
				{
					global.window_scale--;
				}
				else if _input_press.right && global.window_scale < 4
				{
					global.window_scale++;
				}
				else
				{
					break;
				}
				
				if !window_get_fullscreen()
				{
					window_resize();
				}
				
			break;
			
			case 4:
				
				var _is_fullscreen = window_get_fullscreen();
				
				if _input_press.left && _is_fullscreen
				{
					window_disable_fullscreen();
				}
				else if _input_press.right && !_is_fullscreen
				{
					window_enable_fullscreen();
				}
				
			break;
			
			case 5:
				
				if window_get_fullscreen()
				{
					audio_sfx_play(snd_fail);
					break;
				}
				
				var _is_exclusive = !window_get_borderless_fullscreen();
				
				if _input_press.left && _is_exclusive
				{
					window_enable_borderless_fullscreen(true);
				}
				else if _input_press.right && !_is_exclusive
				{
					window_enable_borderless_fullscreen(false);
				}
				
			break;
			
			case 6:
				
				var _is_vsync = global.vsync;
				
				if _input_press.left && _is_vsync
				{
					global.vsync = false;
				}
				else if _input_press.right && !_is_vsync
				{
					global.vsync = true;
				}
				else
				{
					break;
				}
				
				display_reset(0, global.vsync);
			
			break;
		}
		
		alter_setting(option_id);
		
	break;
	
	// Player 1 selection
	case 4:	
	
		global.player_main = option_id;
		load_category(5);
		
	break;
	
	// Player 2 selection
	case 5:
	
		global.player_cpu = option_id == (category_options_count - 1) ? PLAYER.NONE : option_id;
		global.continue_count = 3;
		global.emerald_count = 0;
		global.score_count = 0;
		global.life_count = 3;
		
		game_save_data(global.current_save_slot);
		game_clear_level_data_all();
		room_goto(room_to_load);
		
	break;
}