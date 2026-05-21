/// @self
/// @description Toggles the game window to normal mode and makes the cursor visible.
function window_disable_fullscreen()
{
	window_set_fullscreen(false);
	window_set_cursor(cr_default);
	window_resize();
}