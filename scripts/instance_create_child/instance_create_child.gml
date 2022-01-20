/// @function instance_create_child(x,y,obj)
function instance_create_child(x,y,obj)
{
	// Create the object
	var  NewObject = instance_create_depth(floor(x), floor(y), depth, obj);
	with NewObject
	{
		instance_initialise();
	}
	if !variable_instance_exists(id, "Obj_ChildrenIDs")
	{
		// For some reason the same thing from the instance_initialise() doesn't work for this frame...
		Obj_ChildrenIDs = [];
	}
	array_push(Obj_ChildrenIDs, NewObject);
	
	// Return ID of the created object
	return NewObject;
}