function ObjExplosionScript()
{
	// Make visible
	if Init
	{
		object_set_visibility(true);
	}
	Init = true; 
	
	// Destroy
	if image_index = image_number - 1
	{
		instance_destroy();
	}
}