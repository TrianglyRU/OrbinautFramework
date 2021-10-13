/// @function animate_sprite(frames,speed)
function animate_sprite(frames,speed)
{
	// If there is Player object in the room, check if they are alive
	if !variable_check(Player, "Death")
	{
		// Change sprite subimage
		return Game.GlobalTime div speed mod frames;
	}
	
	// Else return first frame
	return 0;
}