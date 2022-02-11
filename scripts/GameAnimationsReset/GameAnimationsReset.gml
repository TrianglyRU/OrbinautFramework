function GameAnimationsReset()
{
	ds_map_destroy(Game.AnimationTime); 
	
	Game.AnimationTime	  = -1;
	Game.UpdateAnimations = false;
}