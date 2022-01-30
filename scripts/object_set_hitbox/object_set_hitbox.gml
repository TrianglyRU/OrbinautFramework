/// @function object_set_hitbox(xradius,yradius)
function object_set_hitbox(xradius,yradius)
{		
	Obj_HitX	    = xradius;
	Obj_HitY		= yradius;
	Obj_SolidTouchU = false;
	Obj_SolidTouchD = false;
	Obj_SolidTouchL = false;
	Obj_SolidTouchR = false;
	Obj_SolidPush   = false;
}