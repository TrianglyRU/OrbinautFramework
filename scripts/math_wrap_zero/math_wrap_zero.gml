/// @function wrap_zero(x, max)
function wrap_zero(X, Max) 
{
	return (X % Max + Max) % Max;
}