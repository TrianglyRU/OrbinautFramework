/// @function palette_updt_colour(palType,rowID,fromColumnID,toColumnID,duration)
function palette_updt_colour(palType,rowID,fromColumnID,toColumnID,duration)
{
	if Palette.ColourSet[palType] == false or !Renderer.UpdateAnimations
	{
		return;
	}
	
	// YoYo, fix your engine!!!
	var CrashFix = Palette.Sequence;
		CrashFix = Palette.Duration;
		CrashFix = Palette.SwapTime;
	
	// Get unique ID for this palette sequence
	var SequenceID = string(fromColumnID) + "_" + string(toColumnID);
	
	// Initialise palette sequence
	var CurrentSequence  = Palette.Sequence[palType,rowID];
	if  CurrentSequence != SequenceID
	{
		Palette.Sequence[palType,rowID] = SequenceID;
		Palette.Duration[palType,rowID] = duration;
		Palette.SwapTime[palType,rowID] = duration;
	}
	
	// Update sequence
	if duration
	{
		if !(--Palette.SwapTime[palType,rowID])
		{
			// Update colour
			if palType == PalPrimary
			{
				if (++Palette.IndexType1[rowID]) > toColumnID
				{
					Palette.IndexType1[rowID] = fromColumnID;
				}
			}
			else if palType == PalSecondary
			{
				if (++Palette.IndexType2[rowID]) > toColumnID
				{
					Palette.IndexType2[rowID] = fromColumnID;
				}
			}
			
			// Reset duration
			Palette.SwapTime[palType,rowID] = Palette.Duration[palType,rowID];
		}
	}
}