/// @function loop_value(value,lowerBound,upperBound)
function loop_value(value,lowerBound,upperBound)
{
	// Loop the value through given boundaries
	value = (value - lowerBound) % (upperBound - lowerBound);
	
	// Return result
	return (value >= 0 ? value + lowerBound : upperBound + value);
}