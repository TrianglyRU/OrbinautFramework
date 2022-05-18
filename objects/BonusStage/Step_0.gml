/// @description Main
// You can call your scripts in this editor
	
	switch State
	{
		case 0:
		{
			if !fade_check(StateActive)
			{
				// Give 10 rings
				if Input.APress
				{
					global.BonusStageData[0] += 10;
					audio_sfx_play(choose(sfxRingLeft, sfxRingRight), false);
						
					// Grant extra life
					if global.BonusStageData[0] >= RingTarget
					{
						global.Lives += 1;
						RingTarget += 100;
						
						audio_bgm_play(AudioSecondary, ExtraLife);	
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
					global.BonusStageData[1] = Random;
				}
				else if Input.StartPress
				{
					fade_perform(ModeInto, BlendBlack, 1);
	
					audio_bgm_stop(AudioPrimary,   0.5);
					audio_bgm_stop(AudioSecondary, 0.5);
					
					// Increment state
					State++;
				}
			}
		}
		break;
		case 1:
		{
			// Return back to the stage / devmenu
			if fade_check(StateMax)
			{
				if array_length(global.StarPostData)
				{
					room_goto(global.StageRoom);
				}
				else
				{
					global.BonusStageData = [];
					room_goto(Screen_DevMenu);
				}
			}
		}
	}