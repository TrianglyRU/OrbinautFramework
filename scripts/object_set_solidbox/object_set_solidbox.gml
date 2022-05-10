/// @function object_set_solidbox(xradius,yradius,heightmap)
function object_set_solidbox(xradius,yradius,heightmap)
{
	Obj_SolidX		= xradius;
	Obj_SolidY		= yradius;
	Obj_SolidMap	= heightmap;
	Obj_SolidTouchU = false;
	Obj_SolidTouchD = false;
	Obj_SolidTouchL = false;
	Obj_SolidTouchR = false;
	Obj_SolidPush   = false;
}