/// @function loop_value(value,return_to,reset_at)
function loop_value(value,return_to,reset_at)
{
	// Loop the value through given boundaries
	value = (value - return_to) % (reset_at - return_to);
	
	return (value >= 0 ? value + return_to : reset_at + value);
}