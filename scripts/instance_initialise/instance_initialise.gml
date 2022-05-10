/// @function instance_initialise()
function instance_initialise()
{
	/* This script is called automatically when needed! */
	
	if !variable_instance_exists(id, "Obj_AnimDuration")
	{
		Obj_AnimTimer     = 0;
		Obj_AnimDuration  = 0;
		Obj_AnimLoopframe = 0;
		image_speed		  = 0;
	}
	if !variable_instance_exists(id, "Obj_SolidX")
	{
		Obj_SolidX		= 0;
		Obj_SolidY		= 0;
		Obj_SolidMap	= false;
		Obj_SolidTouchU = false;
		Obj_SolidTouchD = false;
		Obj_SolidTouchL = false;
		Obj_SolidTouchR = false;
		Obj_SolidPush   = false;
	}
	if !variable_instance_exists(id, "Obj_HitX")
	{
		Obj_HitX = 0;
		Obj_HitY = 0;
	}
	if !variable_instance_exists(id, "Obj_TriggerLeft")
	{
		Obj_TriggerLeft   = 0;
		Obj_TriggerRight  = 0;
		Obj_TriggerTop    = 0;
		Obj_TriggerBottom = 0;
	}
	if !variable_instance_exists(id, "Obj_UnloadType")
	{
		Obj_UnloadType = false;
		Obj_UnloadData = [];
	}
}