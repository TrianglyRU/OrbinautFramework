function GameAnimationsReset()
{
	Game.UpdateAnimations = false;
	ds_map_destroy(Game.AnimationTime);
}