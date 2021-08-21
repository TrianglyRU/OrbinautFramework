/// @function loop_value(value,min,resetlimit)
function loop_value(value,min,resetlimit)
{
	// Loop the value through given boundaries
	value = (value - min) % (resetlimit - min);
	
	return (value >= 0 ? value + min : resetlimit + value);
}