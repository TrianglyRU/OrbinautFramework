/// @function animation_reset(frame)
function animation_reset(frame)
{
	if is_array(Obj_AnimDuration)
	{
		Obj_AnimTimer = Obj_AnimDuration[frame] + 1;
	}
	else
	{
		Obj_AnimTimer = Obj_AnimDuration + 1;
	}
	image_index = frame;
}