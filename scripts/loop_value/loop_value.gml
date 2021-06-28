/// @function loop_value(x,min,max)
function loop_value(x, min, max)
{
	x = (x - min) % (max - min);
	return (x >= 0 ? x : max + x) + min;
}