/// @description Scripts Event
// You can call your scripts in this editor
	
	// Fade out music
	if instance_exists(Stage)
	{
		if Stage.State = ActStateFinished
		{
			audio_group_set_gain(BGM, 0, 500);
		}
	}