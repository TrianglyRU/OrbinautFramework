/// @function object_check_instances(targetObject)
function object_check_instances(targetObject)
{
	// Check if this object radiuses were initialized
	if !variable_instance_exists(id, "objXRadiusHit")
	{
		show_message("Object ID " + string(id) + " does not have any hitbox radiuses to check for collision with other instances! Please, call 'object_set_hitbox' function in Create event");
		game_end();
		exit;
	}
	
	// Check if target instance raiduses were initialized
	if !variable_instance_exists(targetObject, "objXRadiusHit")
	{
		show_message("Object ID " + string(targetObject) + " does not have any hitbox radiuses to check for collision! Please, call 'object_set_hitbox' function in Create event");
		game_end();
		exit;
	}
	
	// Get object size
	var objectTop    = floor(y - objYRadiusHit);
	var objectLeft   = floor(x - objXRadiusHit);
	var objectRight  = floor(x + objXRadiusHit - 1);
	var objectBottom = floor(y + objYRadiusHit - 1);
	
	// Get target object size
	var targetTop    = floor(targetObject.y - targetObject.objYRadiusHit);
	var targetLeft   = floor(targetObject.x - targetObject.objXRadiusHit);
	var targetRight  = floor(targetObject.x + targetObject.objXRadiusHit - 1);
	var targetBottom = floor(targetObject.y + targetObject.objYRadiusHit - 1);
		
	// Check for overlap horizontally
	if targetRight < objectLeft or targetLeft > objectRight
	{
		return false;
	}
		
	// Check for overlap vertically
	if targetBottom < objectTop or targetTop > objectBottom
	{
		return false;
	}
		
	// If another overlaps object on both axis, it collided with this object
	return true;
}