/// @function object_set_depth(relObject, renderAbove)
function object_set_depth(relObject, renderAbove)
{
	// Apply depth relative to the player
	if relObject == Player
	{
		depth = Player.DrawOrder - (renderAbove ? 5 : -5);
	}
	
	// Apply depth relative to another object
	else
	{
		depth = relObject.depth - (renderAbove ? 5 : -5);
	}
}