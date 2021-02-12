/// @function palette_cycle_perform(index, colours, duration)
function palette_cycle_perform(index, colours, duration)
{
	Game.PalIndex[index] = wrap(Stage.Time / duration, 0, colours) + 1;
}