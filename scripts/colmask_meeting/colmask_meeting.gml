/// @function colmask_meeting(X, Y, onlyFullSolid) 
function colmask_meeting(X, Y, onlyFullSolid) 
{	
	// Get an ID of the collision mask object at given coordinates
	var FoundCollision = instance_position(X, Y, CollisionMasks);

	// If collision mask found, use its ID
	if FoundCollision
	{
		var MaskID = FoundCollision;		
	} 
	else 
	{
		return false;
	}
	
	// Get variables
	var MaskIDLayer    = variable_instance_get(MaskID, "LayerID");
	var MaskIDSolidity = variable_instance_get(MaskID, "Solidity");
	
	// Get those values to debug
	var DebugMaskLayer  = MaskIDLayer == "Layer A" ? "LAYER A" : (MaskIDLayer == "Layer B" ? "LAYER B" : "BOTH LAYERS");
	var DebugMaskSolid  = MaskIDSolidity == "Solid All" ? "SOLID ALL" : "SOLID TOP";
	Game.TempValue[98]  = MaskID;
	Game.TempValue[99]  = DebugMaskLayer;
	Game.TempValue[100] = DebugMaskSolid;
	
	// Compare to current player's layer and check if it is full solid
	if Player.Layer = LayerA && MaskIDLayer = "Layer B" || Player.Layer = LayerB && MaskIDLayer = "Layer A"
	{
		return false;
	}
	if onlyFullSolid 
	{
		if  MaskIDSolidity = "Solid Top"
		{
			return false;
		}
	} 
	
	// Confirm collision if all the checks has been done
	return true;
}