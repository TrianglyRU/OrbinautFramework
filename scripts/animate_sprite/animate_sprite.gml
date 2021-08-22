/// @function animate_sprite(frames,speed)
function animate_sprite(frames,speed)
{
	// Change sprite subimage
	return Game.AnimationTime div speed mod frames;
}