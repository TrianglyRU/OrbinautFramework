// Handle general input and option navigation
var _input_press = input_get_pressed(0);

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
	m_devmenu_alter_option(option_id, $"SAVE {option_id - 1}");
	game_delete_data(option_id - 1);	
	exit;
}

if _input_press.action2
{
	if category_id == 3
	{
		game_save_settings();
	}

	m_devmenu_load_category(all_categories_data[? category_id][0]);
	exit;
}

// Handle input based on the current category
switch category_id
{
	case 3:
		
		// For settings menu, react only to left & right inputs
		if !_input_press.left && !_input_press.right
		{
			exit;
		}
		
	break;
	
	default:
		
		// For everything else, react only to action1 and start inputs
		if !_input_press.action1 && !_input_press.start
		{
			exit;
		}
		
	break;
}

// Handle actions for each menu category
switch category_id
{	
	// Main menu
	case 0:
	
		switch option_id
		{
			case 0:
			
				m_devmenu_load_category(1);

				for (var i = 0; i < 4; i++)
				{
					if game_check_data(i)
					{
						m_devmenu_alter_option(i + 1, $"SAVED GAME {i}");
					}
				}
				
			break;

			case 1:	
			
				if global.dev_mode
				{
					m_devmenu_load_category(2);
				}
				else
				{
					audio_play_sfx(sfx_fail);
				}	
				
			break;

			case 2:
				m_devmenu_load_category(3);
			break;

			case 3:
				game_end();
			break;
		}
		
	break;
	
	// Start game
	case 1:
	
		global.current_save_slot = option_id - 1;

		if !game_check_data(global.current_save_slot)
		{
			room_to_load = rm_stage_tsz0;
			m_devmenu_load_category(4);
			
			break;
		}

		game_clear_temp_data();
		game_load_data(global.current_save_slot);
		
		// Load a stage based on loaded global.stage_index from the save data
		switch global.stage_index
		{
			default:
				room_goto(rm_stage_tsz0);
		}
		
	break;
	
	// Room selection
	case 2:

		room_to_load = option_id;
		
		if room_to_load == noone
		{
			audio_play_sfx(sfx_fail);
			break;
		}

		global.current_save_slot = -1;
		m_devmenu_load_category(4);
		
	break;
	
	// Settings menu
	case 3:
	
		switch option_id
		{
			case 0:
			
				global.gamepad_rumble = !global.gamepad_rumble;

				if global.gamepad_rumble
				{
					input_set_rumble(0, 0.15, INPUT_RUMBLE_MEDIUM, INPUT_RUMBLE_MEDIUM);
				}
				
			break;

			case 1:
			
				if _input_press.left
				{
					global.music_volume -= 0.1;
				}
				else if _input_press.right
				{
					global.music_volume += 0.1;
				}
				else
				{
					break;
				}

				global.music_volume = clamp(global.music_volume, 0, 1);
				audio_play_bgm(bgm_actclear);
				
			break;

			case 2:
			
				if _input_press.left
				{
					global.sound_volume -= 0.1;
				}
				else if _input_press.right
				{
					global.sound_volume += 0.1;
				}
				else
				{
					break;
				}

				global.sound_volume = clamp(global.sound_volume, 0, 1);
				audio_play_sfx(sfx_ring_left);
				audio_play_sfx(sfx_ring_right);
				
			break;

			case 3:
			
				if _input_press.left
				{
					global.window_scale--;
				}
				else if _input_press.right
				{
					global.window_scale++;
				}
				else
				{
					break;
				}

				global.window_scale = clamp(global.window_scale, 1, 4);	
				var _w = global.init_resolution_w * global.window_scale;
				var _h = global.init_resolution_h * global.window_scale;
				
				window_set_size(_w, _h);
				window_center();
				
			break;

			case 4:
				window_set_fullscreen(!window_get_fullscreen());				
			break;

			case 5:
			
				global.use_vsync = !global.use_vsync;
				display_reset(0, global.use_vsync);
				
			break;
		}

		m_devmenu_alter_setting(option_id);
		
	break;
	
	// Player 1 selection
	case 4:
	
		global.player_main = option_id;
		m_devmenu_load_category(5);
		
	break;
	
	// Player 2 selection
	case 5:
	
		global.player_cpu = option_id == 4 ? PLAYER_NOONE : option_id;
		global.continue_count = 0;
		global.emerald_count = 0;
		global.score_count = 0;
		global.life_count = 3;

		game_clear_temp_data();
		game_save_data(global.current_save_slot);
		room_goto(room_to_load);
		
	break;
}