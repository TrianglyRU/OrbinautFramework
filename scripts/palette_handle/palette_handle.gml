/// @function palette_handle(index, colours, duration)
function palette_handle(index, colours, duration)
{
	if colours > 1
	{
		Game.PalIndex[index] = loop_value(Stage.Time / duration, colours) + 1;
	}
	else
	{
		Game.PalIndex[index] = 1;
	}
}