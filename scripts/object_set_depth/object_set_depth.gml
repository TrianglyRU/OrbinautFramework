/// @function object_set_depth(relObject, renderAbove)
function object_set_depth(relObject, renderAbove)
{
	/* We do +- 5 because there can be other things attached to the player
	like Tails' tails or shields, so we should have some space for them */
	
	// Apply depth relative to the player
	if relObject == Player
	{
		depth = Player.DrawOrder - (renderAbove ? 1 : -1);
	}
	
	// Apply depth relative to another object
	else
	{
		depth = relObject.depth - (renderAbove ? 1 : -1);
	}
}