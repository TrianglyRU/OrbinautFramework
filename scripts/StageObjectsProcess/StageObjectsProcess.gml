function StageObjectsProcess()
{
	// Force activate all objects inside of the largest region
	instance_activate_region(Camera.ViewX div 256 * 256, 0, 768, room_height, true);
}