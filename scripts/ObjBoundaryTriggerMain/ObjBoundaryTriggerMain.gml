function ObjBoundaryTriggerMain()
{
	// Update target boundary
	if object_check_overlap(TypeTrigger)
	{
		Stage.TargetBottomBoundary = y;
	}
}