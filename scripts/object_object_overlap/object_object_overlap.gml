/// @function object_object_overlap(targetObject)
function object_object_overlap(targetObject)
{
	// Exit the code if this object hitbox wasnn't initialized
	if (!variable_instance_exists(id, "objXRadiusHit")) exit;
	
	// Exit the code if target object hitbox wasn't initialized
	if (!variable_instance_exists(targetObject, "objXRadiusHit")) exit;
	
	// Get this object size
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
		
	// If this object another overlaps object on both axis, they collided
	return true;
}