function ObjSpecialRingMain()
{
	switch State
	{
		case 0:
		{
			// Delete this ring if it was used before
			if !array_equals(Game.SpecialRingList, [])
			{
				for (var i = 0; i < array_length(Game.SpecialRingList); i++)
				{
					if id == Game.SpecialRingList[i]
					{
						instance_destroy();
					}
				}
			}
			
			// Make the ring visible
			visible = true;
			
			// Increment state
			State++;
		}
		break;
		case 1:
		{
			// Play animation
			animation_play(spr_obj_specialring, 8, 0);
			
			// Check for overlap
			if object_check_overlap(Hitbox)
			{	
				// Play sound
				audio_sfx_play(sfxSpecialRing, false);
				
				// Remember this ring
				if !array_equals(Game.SpecialRingList, [])
				{
					Game.SpecialRingList[array_length(Game.SpecialRingList)] = id;
				}
				else
				{
					Game.SpecialRingList[0] = id;
				}
					
				// If we have all emeralds, give 50 rings
				if Game.Emeralds == 7
				{
					Player.Rings += 50;
					instance_destroy();
				}
				else
				{
					// Remember position and time
					Game.SpecialRingData[0] = x;
					Game.SpecialRingData[1] = y;
					Game.SpecialRingData[2] = Stage.Time;
					
					// Remember current score and stage boundary
					Game.Score		   = Player.Score;
					Game.StageBoundary = Stage.BottomBoundary;
					
					// Create flash object
					instance_create(x, y, SpecialRingFlash);
					sprite_index = spr_obj_specialring_collected;
					
					// Increment state
					State++;
				}
			}
		}
		break;
		case 2:
		{	
			// Stop player
			with Player
			{
				Xsp		= 0;
				Ysp		= 0;
				visible = 0;
			}
			
			// If Tails, stop sounds
			if Game.Character == CharTails
			{
				audio_sfx_stop(sfxTired);
				audio_sfx_stop(sfxFlying);
			}
			
			// Perform fade after 32 frames
			if (++Timer) == 32
			{
				audio_play_sound(sfxSpecialWarp, 0, false);
				fade_perform(FadeTo, ColourWhite, 1);
			}
		}
		break;
	}
}