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
			fade_perform(FadeTo, FadeWhite, 1);
		}
		if fade_check(FadeMax)
		{
			room_goto(SpecialMainRoom);
		}
	}
	else if image_xscale == 1 and object_player_overlap(CollisionHitbox)
	{	
		audio_sfx_play(sfxSpecialRing, false);
		
		if Game.Emeralds != 7
		{
			State			      = 2;
			Input.IgnoreInput	  = true;
			Player.AllowCollision = false;
		
			// Remember position
			Game.PlayerPosition[0] = x;
			Game.PlayerPosition[1] = y;
		
			// Remember this ring
			if !array_equals(Game.SpecialRingIDs, [])
			{
				Game.SpecialRingIDs[array_length(Game.SpecialRingIDs)] = id;
			}
			else
			{
				Game.SpecialRingIDs[0] = id;
			}
			
			if Game.Character == CharTails
			{
				instance_destroy(TailsObject);
				audio_sfx_stop(sfxTired);
				audio_sfx_stop(sfxFlying);
			}
		}
		else
		{
			Player.Rings += 50;
			instance_destroy();
		}
	}

	if Timer < 6
	{
		draw_self();
	}