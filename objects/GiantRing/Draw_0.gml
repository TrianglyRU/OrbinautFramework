/// @description Insert description here
// You can write your code in this editor
	
	if State == 2
	{
		Timer++;
		with Player
		{
			Xsp = 0;
			Ysp = 0;
			image_alpha = 0;
		}
		if Timer < 16
		{
			draw_sprite(spr_giant_ring_flash, Timer div 2, x, y);
		}
		if Timer == 32
		{
			fade_perform(to, white, 1);
		}
		if Timer == 64
		{
			room_goto(SpecialStage);
		}
	}
	else if image_xscale == 1 and object_player_overlap(CollisionHitbox)
	{	
		State = 2;
		Input.IgnoreInput = true;
		Input.ResetInput  = true;
	}

	if Timer < 6
	{
		draw_self();
	}