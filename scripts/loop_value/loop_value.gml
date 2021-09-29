/// @function loop_value(value,returnTo,resetAt)
function loop_value(value,returnTo,resetAt)
{
	// Loop the value through given boundaries
	value = (value - returnTo) % (resetAt - returnTo);
	
	// Return result
	return (value >= 0 ? value + returnTo : reset_at + value);
}