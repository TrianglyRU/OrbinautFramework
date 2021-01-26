/// @function wrap(x, min, max)
function wrap(X, Min, Max) 
{
	var Dif = Max - Min;
	return (((X - Min) % Dif) + Dif) % Dif + Min;
}