/// @description Insert description here
// You can write your code in this editor
	
	if Input.StartPress and !GamePaused
	{
		Input.StartPress = false;
		GamePaused = true;
		Screen.PauseScreen = sprite_create_from_surface(application_surface, 0, 0, Game.ResolutionWidth, Game.ResolutionHeight, false, false, 0, 0);
		instance_deactivate_object(UnloadFar);
		instance_deactivate_object(UnloadClose);
	}