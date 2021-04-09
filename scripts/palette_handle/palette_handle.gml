/// @function palette_handle(index, colours, duration)
function palette_handle(index, colours, duration)
{
	Game.PalIndex[index] = loop_value(Stage.Time / duration, 0, colours) + 1;
}