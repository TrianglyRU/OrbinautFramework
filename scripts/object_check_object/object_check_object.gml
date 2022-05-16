/// @function object_check_object(target)
function object_check_object(target)
{
    // If our target object exist, get the nearest one to the current object, else exit
    if !instance_exists(target)
    {
		return false;
    }
	var targetObj = instance_nearest(x, y, target);

    // Exit if one of the objects doesn't have hitbox initialised
    if !Obj_HitX or !Obj_HitY or !targetObj.Obj_HitX or !targetObj.Obj_HitY
    {
        return false;
    }
            
    // Get sizes
    var ThisTop    = floor(y - Obj_HitY);
    var ThisLeft   = floor(x - Obj_HitX);
    var ThisRight  = floor(x + Obj_HitX - 1);
    var ThisBottom = floor(y + Obj_HitY - 1);
    
    var TargetTop    = floor(targetObj.y - targetObj.Obj_HitY);
    var TargetLeft   = floor(targetObj.x - targetObj.Obj_HitX);
    var TargetRight  = floor(targetObj.x + targetObj.Obj_HitX);
    var TargetBottom = floor(targetObj.y + targetObj.Obj_HitY);
    
    // Check for overlap
    if TargetRight < ThisLeft or TargetLeft > ThisRight
    {
        return false;
    }
    if TargetBottom < ThisTop or TargetTop > ThisBottom
    {
        return false;
    }
    return true;
}
