/// @function object_set_depth(abovePlayer)
function object_set_depth(abovePlayer)
{
	depth = Player.DrawOrder - (abovePlayer ? 1 : -1);
}