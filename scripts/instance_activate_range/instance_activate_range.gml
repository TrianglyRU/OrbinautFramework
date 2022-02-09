/// @function instance_activate_range(anchorX)
function instance_activate_range(anchorX)
{
	static CurrentRegion = -1;
	
	// Activate region
	instance_activate_region((anchorX - 128) & -128, 0, ((Game.Width + 128) & -128) + 256, room_height, true);
	
	// If we loaded a new region, load children objects
	if (anchorX - 128) & -128 != CurrentRegion
	{
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
	CurrentRegion = (anchorX - 128) & -128;
}