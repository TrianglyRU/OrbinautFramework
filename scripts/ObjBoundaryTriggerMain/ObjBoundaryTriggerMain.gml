function ObjBoundaryTriggerMain()
{
	// Update target boundaries
	if object_player_overlap(Triggerbox)
	{
		Stage.TargetBottomBoundary = BottomBoundary;
		Stage.TargetTopBoundary    = TopBoundary;
	}
}