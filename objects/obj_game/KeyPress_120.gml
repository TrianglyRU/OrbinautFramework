/// @description Toggle GM Profiler
if !global.dev_mode
{
	return;
}

var _bool = !is_debug_overlay_open();
	
show_debug_overlay(_bool);
show_debug_log(_bool);
	
if window_get_fullscreen()
{
	if _bool
	{
		window_set_cursor(cr_default);
	}
	else
	{
		window_set_cursor(cr_none);
	}
}