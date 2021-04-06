/// @function loop_value(x, min, max)
function loop_value(X, Min, Max) 
{
	var Dif = Max - Min;
	return (((X - Min) % Dif) + Dif) % Dif + Min;
}