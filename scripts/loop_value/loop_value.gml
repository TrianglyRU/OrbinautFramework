/// @function loop_value(x,min,max)
function loop_value(X, Min, Max)
{
	X = (X - Min) % (Max - Min);
	return (X >= 0 ? X : Max + X) + Min;
}