function ObjBoundaryTriggerMain()
{
	// Update target boundary
	if object_check_touch(TypeTrigger)
	{
		Stage.TargetBottomBoundary = y;
	}
}