/// @function instance_activate_range(anchorX)
function instance_activate_range(anchorX)
{
	instance_activate_region((anchorX - 128) & -128, 0, ((Game.Width + 128) & -128) + 256, room_height, true);
	
	// If there are children for the object, activate them as well
	with all
	{
		var Length = array_length(Obj_ChildrenIDs);
		if  Length
		{
			for (var i = 0; i < Length; i++)
			{
				instance_activate_object(Obj_ChildrenIDs[i]);
			}
		}
	}
}