function ObjSpecialRingMain()
{
	switch State
	{
		case 0:
		{
			// Delete this ring if it was used before
			var Length = array_length(Game.SpecialRingList);
			if  Length
			{
				for (var i = 0; i < Length; i++)
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
			// Check for overlap
			if object_check_overlap(TypeHitbox)
			{	
				// Play sound
				audio_sfx_play(sfxSpecialRing, false);
				
				// Remember this ring
				Game.SpecialRingList[array_length(Game.SpecialRingList)] = id;
				
				// If we have all emeralds, give 50 rings
				if Game.Emeralds == 7
				{
					Player.Rings += 50;
					instance_destroy();
				}
				else
				{
					// Remember player and stage data
					Game.SpecialRingData[0] = x;
					Game.SpecialRingData[1] = y;
					Game.SpecialRingData[2] = Player.Rings;
					Game.SpecialRingData[3] = Player.BarrierType;
					Game.SpecialRingData[4] = Stage.Time;
					Game.SpecialRingData[5] = Stage.TargetBottomBoundary;
						
					// Buffer score and lives into their global variables
					Game.Score = Player.Score;
					Game.Lives = Player.Lives;
					
					// Create flash object
					instance_create(x, y, SpecialRingFlash);
					image_alpha = 0;
					
					// Stop player
					with Player
					{
						Xsp		      = 0;
						Ysp			  = 0;
						Inertia		  = 0;
						AllowMovement = 0;
						visible		  = 0;
					}
			
					// If playing as Tails, stop his sounds
					if Game.Character == CharTails
					{
						audio_sfx_stop(sfxTired);
						audio_sfx_stop(sfxFlying);
					}
					
					// Destroy barrier (in S3/SK they don't do this, but it is stupid)
					Player.BarrierType = false;
					
					// Increment state
					State++;
				}
			}
		}
		break;
		case 2:
		{	
			// Perform fade after 32 frames
			if (++Timer) == 32
			{				
				fade_perform(ModeInto, BlendWhite, 1);
				
				// Play sound and increment state
				audio_play_sound(sfxSpecialWarp, 0, false);
				State++;
				
				// Stop music instantly
				audio_bgm_stop(ChannelPrimary,  0);
				audio_bgm_stop(ChannelSecondary, 0);
			}
		}
		break;
	}
}