/// @function object_set_depth(target,above_behind)
function object_set_depth(target, renderdepth)
{
	// Apply depth relative to the player
	if target == Player
	{
		depth = Player.DrawOrder - (renderdepth ? 50 : -50);
	}
	
	// Apply depth relative to another object
	else
	{
		depth = target.depth - (renderdepth ? 1 : -1);
	}
}