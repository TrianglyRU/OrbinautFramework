function ObjBoundaryTriggerMain()
{
	// Update target boundaries
	if object_check_overlap(Triggerbox)
	{
		Stage.TargetBottomBoundary = BottomBoundary;
		Stage.TargetTopBoundary    = TopBoundary;
	}
}