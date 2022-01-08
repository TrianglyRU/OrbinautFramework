/// @function instance_create_child(x,y,obj)
function instance_create_child(x,y,obj)
{
	// Create object
	var NewObject = instance_create(x, y, obj);
	
	// Add to the array
	if !variable_instance_exists(id, "Obj_ChildrenIDs")
	{
		Obj_ChildrenIDs = [];
	}
	array_push(Obj_ChildrenIDs, NewObject);
	
	// Return ID of the created object
	return NewObject;
}