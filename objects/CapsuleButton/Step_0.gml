/// @description Insert description here
// You can write your code in this editor
	
	if !Pressed {
		animation_play(spr_capsule_button, 3, 1);
		if Player.OnObject = id
		{
			Pressed = true;
			Stage.State = ActStateFinished;
			y += 8;
			image_index = 0;
		}
	}