/// @function object_setup()
function object_setup()
{	
	// Initialize as an object and set variables
	variable_instance_set(id, "IsStageObject",   "Initialized");
	variable_instance_set(id, "Solidity",		 "noSolidityInfo");
	variable_instance_set(id, "GotPlayerHitbox", "noCollisionInfo");
	variable_instance_set(id,  visible,			 "noRenderInfo");
	variable_instance_set(id,  depth,			 "noDepthInfo");	
}