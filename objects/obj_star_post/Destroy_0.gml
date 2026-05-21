var _stars = array_length(star_objs);

if _stars > 0
{
	for (var _i = 0; _i < _stars; _i++)
	{
		instance_destroy(star_objs[_i]);
	}
}

instance_destroy(lamp_obj);