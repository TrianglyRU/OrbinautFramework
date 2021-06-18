/// @function object_set_depth(target,above|behind)
function object_set_depth(target, renderdepth)
{
	// Apply depth relative to the player
	if target == Player
	{
		depth = Player.DrawOrder - (renderdepth ? 2 : -2);
	}
	
	// Apply depth relative to another object
	else
	{
		depth = target.depth - (renderdepth ? 1 : -1);
	}
}