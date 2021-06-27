/// @function loop_value(x, min, max)
function loop_value(X, Min, Max)
{
	if Min != 0
	{
		X = (X - Min) % (Max - Min) + Min;
		return X >= 0 ? X : Max + X;
		//var Dif = Max - Min;
		//return (((X - Min) % Dif) + Dif) % Dif + Min;
	}
	X = X % Max;
	return X >= 0 ? X : Max + X;
}