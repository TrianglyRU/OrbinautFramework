function BonusStageProcess()
{
	switch State
	{
		case 0:
		{
			if !fade_check(StateActive)
			{
				// Give 10 rings
				if Input.APress
				{
					Game.BonusStageData[0] += 10;
					audio_sfx_play(choose(sfxRingLeft, sfxRingRight), false);
						
					// Grant extra life
					if Game.BonusStageData[0] >= RingTarget
					{
						Game.Lives++;
						audio_bgm_play(ChannelSecondary, ExtraLife);
						
						// Increase amount of required rings
						RingTarget += 100;
					}
				}
	
				// Give random barrier
				else if Input.BPress
				{
					var    Random = choose(BarrierFlame, BarrierThunder, BarrierWater, BarrierNormal);
					switch Random
					{
						case BarrierFlame:
							audio_sfx_play(sfxFlameBarrier, false);
						break;
						case BarrierThunder:
							audio_sfx_play(sfxThunderBarrier, false);
						break;
						case BarrierWater:
							audio_sfx_play(sfxWaterBarrier, false);
						break;
						case BarrierNormal:
							audio_sfx_play(sfxBarrier, false);
						break;	
					}
					Game.BonusStageData[1] = Random;
				}
				else if Input.StartPress
				{
					fade_perform(ModeInto, BlendBlack, 1);
	
					audio_bgm_stop(ChannelPrimary,   0.5);
					audio_bgm_stop(ChannelSecondary, 0.5);
					
					// Increment state
					State++;
				}
			}
		}
		break;
		case 1:
		{
			// Return back to stage
			if fade_check(StateMax)
			{
				room_goto(Game.StageRoom);
			}
		}
	}
	
}