/// @function instance_create_children(x,y,obj)
function instance_create_children(x,y,obj)
{
	var ThisObject = id;
	var NewObject  = instance_create(x, y, obj);
	
	// Add children to the list
	if !variable_instance_exists(id, "Obj_ChildrenIDs")
	{
		Obj_ChildrenIDs[0] = NewObject;
	}
	else
	{
		Obj_ChildrenIDs[array_length(Obj_ChildrenIDs)] = NewObject;
	}
	
	// Return id of the created object
	return NewObject;
}