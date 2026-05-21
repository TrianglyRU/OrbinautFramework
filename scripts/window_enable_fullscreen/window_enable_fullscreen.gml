/// @self
/// @description Toggles the game window to fullscreen mode and hides the cursor.
function window_enable_fullscreen()
{
	window_set_fullscreen(true);
	
	if !is_debug_overlay_open()
	{
		window_set_cursor(cr_none);
	}
}