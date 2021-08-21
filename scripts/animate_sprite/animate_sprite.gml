/// @function animate_sprite(frames,speed)
function animate_sprite(frames,speed)
{
	return Game.AnimationTime div speed mod frames;
}