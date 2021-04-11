/// @function loop_value(x, max)
function loop_value(X, Max) 
{
	return (X % Max + Max) % Max;
}