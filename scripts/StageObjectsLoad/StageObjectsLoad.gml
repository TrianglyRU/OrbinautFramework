function StageObjectsLoad()
{
	// Activate сhildren
	static CurrentRegion = -1;
	static StagePaused   = false;
	
	// If we loaded a new region, load children objects (frame later, thanks GameMaker!)
	if (Camera.ViewX - 128) & -128 != CurrentRegion or Stage.IsPaused != StagePaused
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
		CurrentRegion = (Camera.ViewX - 128) & -128;
	}
}