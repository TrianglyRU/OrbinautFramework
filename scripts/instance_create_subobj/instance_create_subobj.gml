/// @function instance_create_subobj(x,y,obj)
function instance_create_subobj(x,y,obj)
{
	// Create object
	var  NewObject = instance_create_depth(floor(x), floor(y), depth, obj);
	with NewObject
	{
		instance_initialise();
	}
	
	// If this function is called in the create event, global instance_initialise() won't work for that frame
	if event_type == ev_create and !variable_instance_exists(id, "Obj_SubObjectIDs")
	{
		Obj_SubObjectIDs = [];
	}
	array_push(Obj_SubObjectIDs, NewObject);
	
	// Return ID of the created object
	return NewObject;
}