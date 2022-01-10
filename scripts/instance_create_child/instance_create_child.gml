/// @function instance_create_child(x,y,obj)
function instance_create_child(x,y,obj)
{
	// Create object
	var NewObject = instance_create(x, y, obj);
	
	// Initialise animation varaibles for it
	with NewObject
	{
		if !variable_instance_exists(id, "image_duration")
		{
			image_timer     = 0;
			image_duration  = 0;
			image_loopframe = 0;
		}
	}
	
	// Mark this object as a parent and add child object to the list
	if !variable_instance_exists(id, "Obj_ChildrenIDs")
	{
		Obj_ChildrenIDs = [];
	}
	array_push(Obj_ChildrenIDs, NewObject);
	
	// Return ID of the created object
	return NewObject;
}