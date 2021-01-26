/// @function colmask_meeting(X, Y, ignorePlatforms) 
function colmask_meeting(X, Y, ignorePlatforms) 
{	
	// Variables 
	var CollisionMask, MaskID
	var MaskLayer, PlatformFlag;

	// Get a MaskID and proceed if found
	CollisionMask = instance_position(X, Y, CollisionMasks);
	
	if CollisionMask 
	{
		MaskID = CollisionMask;
	} 
	else 
	{
		return false;
	}
	
	// Check for LayerID and proceed
	MaskLayer = variable_instance_get(MaskID, "LayerID");
	if MaskLayer != "Both" and MaskLayer != Player.Layer
	{
		return false;
	}
	
	// Check for being a platform and proceed
	if ignorePlatforms 
	{
		PlatformFlag        = variable_instance_get(MaskID, "JumpThrough");
		return PlatformFlag == false;
	} 
	
	// Return true if all the checks have been done
	return true;
}