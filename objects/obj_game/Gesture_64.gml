/// @description Touchscreen Debug Control
if os_type != os_android && os_type != os_ios
{
	return;
}

if !global.dev_mode
{
	return;
}

var _x = event_data[? "guiposX"];
var _y = event_data[? "guiposY"];

if _y >= RENDER_APPLICATION_HEIGHT * 0.875
{
	if _x < RENDER_APPLICATION_WIDTH * 0.125
	{
		event_perform(ev_keypress, vk_f8);
	}
	else if _x >= RENDER_APPLICATION_WIDTH * 0.875
	{
		event_perform(ev_keypress, vk_escape);
	}
}