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
	
	// Check for LayerID variable and compare it to player's current layer
	var MaskIDLayer = variable_instance_get(MaskID, "LayerID");
	if Player.Layer = LayerA && MaskIDLayer = "Layer B" || Player.Layer = LayerB && MaskIDLayer = "Layer A"
	{
		return false;
	}
	
	// If we check only for full solid masks, ignore top solid ones
	if onlyFullSolid 
	{
		var MaskIDSolidity = variable_instance_get(MaskID, "Solidity");
		if  MaskIDSolidity = "Solid Top"
		{
			return false;
		}
		//return PlatformFlag == false;
	} 
	
	// Confirm collision if all the checks has been done
	return true;
}