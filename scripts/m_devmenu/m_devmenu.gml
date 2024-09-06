/// @method m_devmenu_add_category
m_devmenu_add_category = function()
{
    var _data = 
    [
		0,				// previous category_id
		0,				// stored option_id
		argument[0]		// title
    ];
	
    for (var i = 1; i < argument_count; i++)
    {
        array_push(_data, argument[i]);
    }
	
    ds_map_add(all_categories_data, categories_count, _data);
    categories_count++;
}
/// @method m_devmenu_load_category
m_devmenu_load_category = function(_id)
{
    category_data = all_categories_data[? _id];
    category_options_count = array_length(category_data) - 3;
	
    if _id == category_id
    {
        exit;
    }
	
    if all_categories_data[? category_id][0] == _id
    {
        all_categories_data[? category_id][1] = 0;
        option_id = all_categories_data[? _id][1];
    }
    else
    {
        all_categories_data[? _id][0] = category_id;
        all_categories_data[? category_id][1] = option_id;
        option_id = 0;
    }
	
    if _id == 3
    {
        for (var i = 0; i < category_options_count; i++)
        {
            m_devmenu_alter_setting(i);
        }
    }
	
    category_id = _id;
}

/// @method m_devmenu_alter_option
m_devmenu_alter_option = function(_id, _string)
{
    category_data[_id + 3] = _string;
}

/// @method m_devmenu_alter_setting
m_devmenu_alter_setting = function(_setting_id)
{
    m_devmenu_alter_option(_setting_id, string_split(category_data[_setting_id + 3], ":")[0] + m_devmenu_get_setting(_setting_id));
}

/// @method m_devmenu_get_setting
m_devmenu_get_setting = function(_id)
{
    switch _id
    {
        case 0: return global.gamepad_rumble ? ": TRUE" : ": FALSE";
        case 1: return $": {round(global.music_volume * 100)}%";
        case 2: return $": {round(global.sound_volume * 100)}%";
        case 3: return $": {global.window_scale}X";
        case 4: return window_get_fullscreen() ? ": TRUE" : ": FALSE";
        case 5: return global.use_vsync ? ": TRUE" : ": FALSE";
    }
}
