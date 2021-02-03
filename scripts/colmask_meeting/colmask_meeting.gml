/// @function colmask_meeting(X, Y, onlyFullsolid) 
function colmask_meeting(X, Y, onlyFullsolid) 
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
	
	// Compare to current player's layer and check if it is full solid
	if Player.Layer = LayerA && MaskIDLayer = "Layer B" || Player.Layer = LayerB && MaskIDLayer = "Layer A"
	{
		return false;
	}
	if onlyFullsolid
	{
		if MaskIDSolidity = "Solid Top" 
		{
			return false;
		}
	} 
	
	// Confirm collision if all the checks has been done
	return true;
}