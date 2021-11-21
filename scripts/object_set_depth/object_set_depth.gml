/// @function object_set_depth(target,above)
function object_set_depth(target,renderdepth)
{
	// Apply depth relative to the player
	if target == Player
	{
		switch object_index
		{
			/* You can add your objects for more advanced depth 
			manipulation
			
			Example: case FloatingPlatform: var Tolerance = 25; break;
			*/
			
			default: var Tolerance = 50; break;
		}
		depth = Player.DrawOrder - (renderdepth ? Tolerance : -Tolerance);
	}
	
	// Apply depth relative to another object
	else
	{
		depth = target.depth - (renderdepth ? 1 : -1);
	}
}