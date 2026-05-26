/// @description Touchscreen Debug Control
if os_type != os_android && os_type != os_ios
{
	return;
}

if !global.dev_mode
{
	return;
}

var _w = surface_get_width(application_surface);
var _h = surface_get_height(application_surface);

var _x = event_data[? "guiposX"];
var _y = event_data[? "guiposY"];

if _y >= _h * 0.875
{
	if _x < _w * 0.125
	{
		event_perform(ev_keypress, vk_f8);
	}
	else if _x >= _w * 0.125
	{
		event_perform(ev_keypress, vk_escape);
	}
}