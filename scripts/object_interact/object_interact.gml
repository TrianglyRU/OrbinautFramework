function object_interact(target)
{
	// Exit if one of the objects don't have hitbox initialised
	if !Obj_HitX or !Obj_HitY or !target.Obj_HitX or !target.Obj_HitY
	{
		return false;
	}
			
	// Get sizes
	var ThisTop    = floor(y - Obj_HitY);
	var ThisLeft   = floor(x - Obj_HitX);
	var ThisRight  = floor(x + Obj_HitX - 1);
	var ThisBottom = floor(y + Obj_HitY - 1);
	
	var TargetTop    = floor(target.y - target.Obj_HitY);
	var TargetLeft   = floor(target.x - target.Obj_HitX);
	var TargetRight  = floor(target.x + target.Obj_HitX - 1);
	var TargetBottom = floor(target.y + target.Obj_HitY - 1);
	
	// Check for overlap
	if TargetLeft < ThisRight or TargetRight > ThisLeft
	{
		return false;
	}
	if TargetBottom < ThisTop or TargetTop > ThisBottom
	{
		return false;
	}
	return true;
}