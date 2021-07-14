/// @function loop_value(value,min,resetlimit)
function loop_value(value, min, resetlimit)
{
	value = (value - min) % (resetlimit - min);
	
	return (value >= 0 ? value : resetlimit + value) + min;
}