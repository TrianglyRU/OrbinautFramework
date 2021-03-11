/// @description Insert description here
// You can write your code in this editor
	
	if !Pressed {
		animation_play(spr_capsule_button, 3, 1);
		if hitbox_collision(Player, self)
		{
			Pressed = true;
			Stage.State = ActStateFinished;
			y += 9;
			image_index = 0;
			//Capsule.Timer = 60;
			//other.State = 1;
			//other.ExplDelay = irandom_range(0, 32);
		}
	}