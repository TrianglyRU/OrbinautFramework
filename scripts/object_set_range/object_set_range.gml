/// @function object_set_range(type)
function object_set_range(type)
{
	// Set range
	switch type
	{
		case RangeClose:
		case RangeFar:
			objActiveRange = type;
		break;
		default: break;
	}
}