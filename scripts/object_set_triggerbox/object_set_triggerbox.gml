/// @function object_set_triggerbox(xLeft, xRight, yTop, yBottom)
function object_set_triggerbox(xLeft, xRight, yTop, yBottom)
{
	// Set triggerbox coordinates
	Obj_TriggerLeft   = xLeft;
	Obj_TriggerRight  = xRight;
	Obj_TriggerTop    = yTop;
	Obj_TriggerBottom = yBottom;
	
	// Mark as trigger
	Obj_TriggerStatus = true;
}