/// @function palette_cycle_perform(index, colours, duration)
function palette_cycle_perform(index, colours, duration)
{
	Game.PalIndex[index] = wrap_zero(Stage.Time / duration, colours) + 1;
}