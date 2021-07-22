/// @function object_set_range(type,do_reset)
function object_set_range(type, do_reset)
{
	switch type
	{	
		case RangeFar:
		{
			objLoadRangeX = 128;
			objLoadRangeY = 256;
		}
		break;
		case RangeClose:
		default:
		{
			objLoadRangeX = 32;
			objLoadRangeY = 128;
		}
		break;
	}
	
	objResetData   = [x, y, image_xscale, image_yscale];
	objResetFlag   = do_reset;
	objResetActive = false;
}