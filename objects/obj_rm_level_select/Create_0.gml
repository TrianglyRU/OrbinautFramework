dec_to_hex = function(_number)
{
    var _hex = "";
    var _digits = "0123456789ABCDEF";
    
    if _number == 0
	{
        return "00";
    }
	
    while _number > 0
	{
        _hex = string_char_at(_digits, _number % 16 + 1) + _hex;
        _number = floor(_number / 16);
    }
	
	if string_length(_hex) < 2
	{
	    _hex = "0" + _hex;
	}
	
    return _hex;
}

get_entry_text_array = function(_entry_index)
{
	return string_split(level_entries[_entry_index], "|", false);
}

is_string_entry = function(_entry_index)
{
	var _char = string_char_at(string_trim(level_entries[_entry_index]), 1);
	return _char != "/" && _char != "";
}

set_room_to_load = function()
{
	room_to_load = undefined;
	down_cooldown = 0;
	
	for (var _i = 0; _i < array_length(level_rediretions); _i += 2)
	{
		if level_rediretions[_i] == global.selected_level_entry
		{
			room_to_load = level_rediretions[_i + 1];
			break;
		}
	}
}

on_fade_load_room = function()
{
	if audio_bgm_is_playing() || audio_is_playing(snd_warp_enter)
	{
		return false;
	}
	
	if room_to_load != undefined
	{
		if global.current_save_slot == undefined
		{
			var _player_index = global.selected_player_index;
			
			global.player_main = _player_index < 2 ? PLAYER.SONIC : _player_index - 1;
			global.player_cpu = _player_index == 0 ? PLAYER.TAILS : PLAYER.NONE;
		}
		
		game_clear_level_data_all();
		room_goto(room_to_load);
	}
	else
	{
		room_goto(rm_dev_menu);
	}
		
	return true;
}

scr_level_select_setup();

cheat_code_string = "";
down_cooldown = 0;
room_to_load = undefined;
sound_ids = [];
bg_playback_data = 
[
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    1, 1, 1, 2, 2, 2,
    3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
    3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
    3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
    3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
    3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
    2, 2, 2, 1, 1, 1
];

for (var _i = 0; _i < 256; _i++)
{
	var _sound_name = audio_get_name(_i);
	
    if _sound_name == "<undefined>"
    {
        array_push(sound_ids, -1);
    }
	else if string_starts_with(_sound_name, "snd_bgm")
	{
		array_insert(sound_ids, 0, _i);
	}
	else
	{
		array_push(sound_ids, _i);
	}
}

var _main_player_index = global.player_main;
var _cpu_player_index = global.player_cpu;

if _main_player_index == PLAYER.SONIC && _cpu_player_index == PLAYER.TAILS
{
	global.selected_player_index = 0;
}
else
{
	global.selected_player_index = _main_player_index + 1;
}
	
set_room_to_load();

audio_bgm_play(snd_bgm_level_select);
bg_convert("Background", 0, 0, 0, 0, 0);
discord_set_data("LEVEL SELECT", "", "room_levels", "");
fade_perform_black(FADE_DIRECTION.IN, 1);