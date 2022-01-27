/// @function loop_value(value,lowerBound,upperBound)
function loop_value(value,lowerBound,upperBound)
{
	if value > upperBound
	{
		return lowerBound;
	}
	else if value < lowerBound
	{
		return upperBound;
	}
	else
	{
		return value;
	}
}