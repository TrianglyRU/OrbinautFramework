/// @description Handle Cursor
// You can write your code in this editor
	
	/* Hide cursor if we're in fullscreen. This is kinda slow?
	Disable if not needed and you want to slightly boost the performace */
	if window_get_fullscreen()
	{
		window_set_cursor(cr_none)
	}
	else
	{
		window_set_cursor(cr_default);
	}