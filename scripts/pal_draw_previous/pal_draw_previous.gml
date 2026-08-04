/// @self
/// @description	Restores the previously active palette entry. If no previous palette entry exists, palette rendering is disabled.
function pal_draw_previous()
{
	var _previous = obj_game.palette_entry_previous;
	
	if _previous == undefined
	{
		pal_draw_stop();
	}
	else
	{
		pal_draw(_previous);
	}
}