/// @function animate_sprite(frames,speed)
function animate_sprite(frames,speed)
{
	// Change sprite subimage
	return Game.GlobalTime div speed mod frames;
}