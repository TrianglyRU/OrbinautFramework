/// @function object_set_hitbox(xradius,yradius)
function object_set_hitbox(xradius,yradius)
{		
	// Set hitbox radiuses
	Obj_HitX = xradius;
	Obj_HitY = yradius;
	
	// Mark as interactive
	Obj_HitStatus = true;
}