/// @function object_set_range(range_type,reset_type)
function object_set_range(range_type, reset_type)
{
	switch range_type
	{	
		case RangeFar:
		{
			Obj_LoadX = 128;
			Obj_LoadY = 256;
		}
		break;
		case RangeClose:
		default:
		{
			Obj_LoadX = 32;
			Obj_LoadY = 128;
		}
		break;
	}
	
	Obj_LoadData  = [x, y, image_xscale, image_yscale];
	Obj_LoadFlag  = reset_type;
	Obj_LoadState = false;
}