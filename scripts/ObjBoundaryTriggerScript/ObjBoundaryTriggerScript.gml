function ObjBoundaryTriggerScript()
{
	// Check if player overlaps the trigger
	if object_player_overlap(CollisionTriggerbox)
	{
		Stage.TargetBottomBoundary = BottomBoundary;
		Stage.TargetTopBoundary    = TopBoundary;
	}
}