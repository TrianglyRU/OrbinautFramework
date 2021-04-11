/// @function loop_value_range(x, min, max)
function loop_value_range(X, Min, Max) 
{
	var Dif = Max - Min;
	return (((X - Min) % Dif) + Dif) % Dif + Min;
}