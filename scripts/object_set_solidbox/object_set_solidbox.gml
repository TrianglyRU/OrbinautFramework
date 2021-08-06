/// @function object_set_solidbox(xradius, yradius, heightmap)
function object_set_solidbox(xradius, yradius, heightmap)
{
	// Set solid radiuses
	Obj_SolidX   = xradius;
	Obj_SolidY   = yradius;
	Obj_SolidMap = heightmap;
	
	// Set touch flags
	Obj_SolidTouchU = false;
	Obj_SolidTouchD = false;
	Obj_SolidTouchL = false;
	Obj_SolidTouchR = false;
	
	// Mark as solid
	Obj_SolidStatus = true;
}