/// @function instance_create(x,y,obj)
function instance_create(x,y,obj)
{
	// Create a new object
	var NewObject = instance_create_depth(floor(x), floor(y), depth, obj);
	
	// Initialise animation varaibles for it
	with NewObject
	{
		if !variable_instance_exists(id, "image_duration")
		{
			image_timer     = 0;
			image_duration  = 0;
			image_loopframe = 0;
			image_framedata = 0;
		}
	}
	
	// Return ID of the created object
	return NewObject;
}