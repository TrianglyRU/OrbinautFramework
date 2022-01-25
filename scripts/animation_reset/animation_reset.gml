/// @function animation_reset(frame)
function animation_reset(frame)
{
	if is_array(Obj_AnimDuration)
	{
		Obj_AnimTimer = Obj_AnimDuration[frame];
	}
	else
	{
		Obj_AnimTimer = Obj_AnimDuration;
	}
	image_index = frame;
}