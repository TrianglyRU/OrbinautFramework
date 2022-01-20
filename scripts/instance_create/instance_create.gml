/// @function instance_create(x,y,obj)
function instance_create(x,y,obj)
{
	// Create the object
	var  NewObject = instance_create_depth(floor(x), floor(y), depth, obj);
	with NewObject
	{
		instance_initialise();
	}
	
	// Return ID of the created object
	return NewObject;
}