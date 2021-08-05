/// @function object_object_overlap(targetObject)
function object_object_overlap(targetObject)
{
	// Exit the code if this object hitbox wasnn't initialized
	if !variable_instance_exists(id, "Obj_HitStatus")
	{
		exit;
	}
	
	// Exit the code if target object hitbox wasn't initialized
	if !variable_instance_exists(targetObject, "Obj_HitStatus")
	{
		exit;
	}
	
	// Exit the code if objects can't overlap
	if !id.Obj_HitX or !id.Obj_HitY or !targetObject.Obj_HitX or !targetObject.Obj_HitY
	{
		return false;	
	}
	
	// Get this object size
	var objectTop    = floor(y - Obj_HitY);
	var objectLeft   = floor(x - Obj_HitX);
	var objectRight  = floor(x + Obj_HitX);
	var objectBottom = floor(y + Obj_HitY);
	
	// Get target object size
	var targetTop    = floor(targetObject.y - targetObject.Obj_HitY - 1);
	var targetLeft   = floor(targetObject.x - targetObject.Obj_HitX - 1);
	var targetRight  = floor(targetObject.x + targetObject.Obj_HitX - 1);
	var targetBottom = floor(targetObject.y + targetObject.Obj_HitY - 1);
	
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