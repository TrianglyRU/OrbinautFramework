function object_spawn(X, Y, objectToSpawn)
{
	// Create object
	return instance_create_depth(X, Y, 0, objectToSpawn);
}