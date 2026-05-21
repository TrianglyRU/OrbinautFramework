#macro DEVM_PARENT_CATEGORY_ID 0
#macro DEVM_SAVED_OPTION_ID 1
#macro DEVM_CATEGORY_TITLE 2
#macro DEVM_CATEGORY_SYSTEM_DATA (DEVM_PARENT_CATEGORY_ID + DEVM_SAVED_OPTION_ID + DEVM_CATEGORY_TITLE)

add_category = function(_title, _entry_array)
{
	// DEVM_PARENT_CATEGORY_ID, DEVM_SAVED_OPTION_ID, DEVM_CATEGORY_TITLE
    var _sys_data = [0, 0, _title];
	
    for (var _i = 0; _i < array_length(_entry_array); _i++)
    {
        array_push(_sys_data, _entry_array[_i]);
    }
	
    ds_map_add(all_categories_data, categories_count++, _sys_data);
}

load_category = function(_new_category_id)
{
	var _category_current = all_categories_data[? category_id];
	var _category_to_load = all_categories_data[? _new_category_id];
	
	if _new_category_id == _category_current[DEVM_PARENT_CATEGORY_ID]
	{
	    _category_current[DEVM_SAVED_OPTION_ID] = 0;
	}
	else
	{
	    _category_to_load[DEVM_PARENT_CATEGORY_ID] = category_id;
		_category_to_load[DEVM_SAVED_OPTION_ID] = 0;
	    _category_current[DEVM_SAVED_OPTION_ID] = option_id;
	}
	
	option_id = _category_to_load[DEVM_SAVED_OPTION_ID];
	category_id = _new_category_id;
	category_data = _category_to_load;
    category_options_count = array_length(_category_to_load) - DEVM_CATEGORY_SYSTEM_DATA;
}

alter_option = function(_option_id, _string)
{
    category_data[_option_id + DEVM_CATEGORY_SYSTEM_DATA] = _string;
}

alter_setting = function(_setting_id)
{
	category_data[_setting_id + DEVM_CATEGORY_SYSTEM_DATA] = string_split(category_data[_setting_id + DEVM_CATEGORY_SYSTEM_DATA], ":")[0] + get_setting(_setting_id);
}

get_setting = function(_id)
{
	var _display = "GET_SETTING() NOT SET";
	
    switch _id
    {
        case 0: 
			_display = global.gamepad_rumble ? "TRUE" : "FALSE";
		break;
		
        case 1:
			_display = string(round(global.music_volume * 100)) + "%";
		break;
		
        case 2:
			_display = string(round(global.sound_volume * 100)) + "%";
		break;
		
        case 3: 
			_display = string(global.window_scale) + "X";
		break;
		
		case 4:
			_display = window_get_fullscreen() ? "FULLSCREEN" : "WINDOWED";
		break;
		
		case 5:
			_display = !window_get_borderless_fullscreen() ? "TRUE" : "FALSE";
		break;
		
		case 6:
			_display = global.vsync ? "TRUE" : "FALSE";
		break;
    }
	
	return ": " + _display;
}

all_categories_data = ds_map_create();
category_data = [];	
categories_count = 0;
category_id = 0;
category_options_count = 0;
option_id = 0;
rooms = [];
room_to_load = -1;

// Automatically generate room list (skip rm_startup)
var _room_names = [];
var _room_id = room_next(room_first);

while _room_id != -1
{
	array_push(rooms, _room_id);
    array_push(_room_names, string_upper(room_get_name(_room_id)));
    
    if _room_id == room_last
    {
        break;
    }

    _room_id = room_next(_room_id);
}

// Settings list
var _settings =
[
	"GAMEPAD RUMBLE",
	"BGM VOLUME",
	"SFX VOLUME",
	"WINDOW SCALE",
	"WINDOW MODE",
	"EXCLUSIVE FULLSCREEN",
	"FULLSCREEN VSYNC"
];

if os_type == os_android || os_type == os_ios
{
	array_pop(_settings);	// remove vsync
	array_pop(_settings);	// remove exclusive fullscreen
	array_pop(_settings);	// remove window mode
	array_pop(_settings);	// remove window scale
}

add_category    // ID 0
(
    "ORBINAUT FRAMEWORK\nDefault Menu",
    [
		"START GAME",
		"ROOM SELECT",
		"SETTINGS",
		"CLOSE GAME"
	]
);
add_category    // ID 1
(
    "START GAME\nPress action 3 to delete a save file",
	[
	    "NO SAVE",
	    "SAVE 0",
	    "SAVE 1",
	    "SAVE 2",
	    "SAVE 3"
	]
);
add_category    // ID 2
(
    "ROOM SELECT",
	_room_names
);
add_category    // ID 3
(
    "SETTINGS",
	_settings
);
add_category    // ID 4
(
    "PLAYER 1 SELECT",
	[
	    "SONIC",
	    "TAILS",
	    "KNUCKLES",
	    "AMY"
	]
);
add_category    // ID 5
(
    "PLAYER 2 SELECT",
	[
	    "SONIC",
	    "TAILS",
	    "KNUCKLES",
	    "AMY",
	    "NO PLAYER 2"
	]
);

load_category(0);

discord_set_data("In Menus", "", "room_menu", "");