function ObjBoundaryTriggerMain()
{
	// Update target boundary
	if object_check_overlap(Triggerbox)
	{
		Stage.TargetBottomBoundary = y;
	}
}