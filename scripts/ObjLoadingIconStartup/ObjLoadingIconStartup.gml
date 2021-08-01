function ObjLoadingIconStartup()
{
	// Variables list
	LoadingSprite = 0;
	
	// Randomly choose loading sprite
	LoadingSprite = choose(spr_obj_loading_sonic, spr_obj_loading_tails, spr_obj_loading_knuckles);
}