/// @function instance_create_children(x,y,obj,array)
function instance_create_children(x,y,obj,array)
{
	// Create object
	var NewObject = instance_create(x, y, obj);
	
	// Add to the list
	if array != false
	{
		array_push(array, NewObject);
		Obj_ChildrenIDs = array;
	}
	
	// Return id of the created object
	return NewObject;
}