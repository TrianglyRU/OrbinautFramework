/// @function instance_activate_range(anchorX)
function instance_activate_range(anchorX)
{
	static CurrentRegion = -1;
	static LeftBound	 = -1;
	static StagePaused   = false;
	
	// If we loaded a new region, load children objects (frame later, thanks GameMaker!)
	if LeftBound != CurrentRegion or Stage.IsPaused != StagePaused
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
		StagePaused   = Stage.IsPaused;
		CurrentRegion = LeftBound;
	}
	
	// Activate region
	var Adjust     = global.Width - 320;
	    LeftBound  = (anchorX & -128) - 128;
		
	instance_activate_region(LeftBound - Adjust, 0, Adjust * 2 + 128 + 640, room_height, true);
}