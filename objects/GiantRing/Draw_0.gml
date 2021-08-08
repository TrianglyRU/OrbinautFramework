/// @description Insert description here
// You can write your code in this editor
	
	if State == 2
	{
		Timer++;
		with Player
		{
			Xsp		= 0;
			Ysp		= 0;
			visible = 0;
		}
		if Timer < 16
		{
			draw_sprite(spr_giant_ring_flash, Timer div 2, x, y);
		}
		if Timer == 32
		{
			audio_play_sound(sfxSpecialWarp, 0, false);
			fade_perform(FadeIn, FadeWhite, 36);
		}
		if fade_check(FadeMax)
		{
			room_goto(SpecialMainRoom);
		}
	}
	else if image_xscale == 1 and object_player_overlap(CollisionHitbox)
	{		
		State = 2;
		Input.IgnoreInput = true;
		
		// Remember position
		Game.PlayerPosition[0] = x;
		Game.PlayerPosition[1] = y;
	}

	if Timer < 6
	{
		draw_self();
	}