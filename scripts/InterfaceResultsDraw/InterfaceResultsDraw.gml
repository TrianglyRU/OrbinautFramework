function InterfaceResultsDraw()
{
	/* Value table
	---------------
	Value[0] - Timer
	Value[1] - Character Head PosX
	Value[2] - 'CHARACTER' PosX
	Value[3] - 'GOT THROUGH PosX
	Value[4] - 'SCORE' PosX
	Value[5] - 'TIME' PosX
	Value[6] - 'RINGS' PosX
	Value[7] - 'ACT' PosX
	Value[8] - State
	---------------
	*/
	
	// Exit if act is not finished
	if Stage.IsFinished < 2
	{
		exit;
	}
	
	// Store initial score
	static InitialScore = Player.Score;
	
	if Stage.DoUpdate
	{	
		// State 0
		if !ResultsValue[7]
		{
			// Calculate ring bonus
			RingBonus = Player.Rings * 100;

			// Calculate time bonus
			if Stage.Time >= 35940
			{
				TimeBonus = 100000;
			}
			else if Stage.Time < 1800
			{
				TimeBonus = 50000;
			}			
			else if Stage.Time >= 1800 and Stage.Time < 2700
			{
				TimeBonus = 10000;
			}
			else
			{
				switch Stage.Time div 1800
				{
					case 0:			
						TimeBonus = 5000; 
					break;
					case 1:			
						TimeBonus = 5000;  
					break;
					case 2:			
						TimeBonus = 4000;  
					break;
					case 3:			
						TimeBonus = 3000;  
					break;
					case 4: 
					case 5: 
						TimeBonus = 2000;  
					break;
					case 6: 
					case 7: 
						TimeBonus = 1000;  
					break;
					case 8: 
					case 9: 
						TimeBonus = 500;   
					break;
					default:
						TimeBonus = 0;	  
					break;
				}
			}			
			ResultsValue[7] = 1;
		}
	
		// State 1
		else if ResultsValue[8] == 1
		{
			// Shift assets
			if (++ResultsValue[0]) < 300
			{
				if ResultsValue[2]
				{
					ResultsValue[2] -= 20;
				}
				else if ResultsValue[3]
				{
					ResultsValue[3] -= 20;
				}
				else if ResultsValue[8]
				{
					if ResultsValue[1]
					{
						ResultsValue[1] -= 20;
					}
					ResultsValue[7] -= 20;
				}
				else
				{		
					if ResultsValue[4]
					{
						ResultsValue[4] -= 20;
					}
					if ResultsValue[5] 
					{
						ResultsValue[5] -= 20;
					}
					if ResultsValue[6] 
					{
						ResultsValue[6] -= 20;
					}
				}
			}
			else
			{
				// Play sound
				if ResultsValue[0] == 300
				{
					audio_sfx_play(sfxScoreCount, true);
				}
			
				// Get 50000 score target
				var LifeReward = max(ceil(Player.Score / 50000) * 50000, 50000);
			
				// Skip bonuses math
				if Input.StartPress
				{
					Player.Score += TimeBonus + RingBonus;
					TimeBonus = 0; 
					RingBonus = 0;
				}
				else
				{
					// Count bonuses
					if TimeBonus
					{ 
						TimeBonus	 -= 100;
						Player.Score += 100;
					}
					if RingBonus
					{
						RingBonus    -= 100;
						Player.Score += 100;
					}
				}
			
				// Grant extra life for exceeding 50000 points
				if Player.Score >= LifeReward
				{
					Game.Lives++;
					audio_bgm_play(PriorityHigh, ExtraLifeJingle, noone);
				}
			
				// Score tally
				if TimeBonus == 0 and RingBonus == 0
				{
					audio_sfx_play(sfxScoreTally, false);
					audio_sfx_stop(sfxScoreCount);
					
					// If earned more than 10000 points, grant continue
					if Player.Score - InitialScore >= 10000
					{
						ResultsValue[8] = 3;
						ResultsValue[0] = -1;
					}
					
					// Else do nothing
					else
					{
						ResultsValue[8] = 2;
						ResultsValue[0] = 0;
					}
				}
			}
		}
	
		// State 2 (end, no continue)
		else if ResultsValue[8] == 2
		{
			if (++ResultsValue[0]) == 180
			{
				fade_perform(FadeTo, FadeBlack, 1);
			}
		}
	
		// State 3 (end with continue earned)
		else if ResultsValue[8] == 3
		{	
			if ResultsValue[0] == -1
			{
				// Play continue sound
				if !audio_is_playing(sfxScoreTally)
				{
					audio_sfx_play(sfxContinue, false);
					
					// Increment routine and continue amount
					Game.Continues++;
					ResultsValue[0]++;
				}
			}
			else if (++ResultsValue[0]) == 260
			{
				fade_perform(FadeTo, FadeBlack, 1);
			}
		}
	}
	
	// Get screen centre
	var ScreenCentre = Game.Width / 2
	
	// Draw assets
	draw_sprite(spr_results_head,		 Game.Character, ScreenCentre + 53 + ResultsValue[1], 87);
	draw_sprite(spr_results_char,		 Game.Character, ScreenCentre - 14 - ResultsValue[2], 60);
	draw_sprite(spr_results_act,		 Stage.ActID,    ScreenCentre + 25 + ResultsValue[7], 78);	
	draw_sprite(spr_results_through,	 0,				 ScreenCentre - 15 - ResultsValue[3], 80);
	draw_sprite(spr_results_score,		 0,				 ScreenCentre - 80 + ResultsValue[4], 119);
	draw_sprite(spr_results_timebonus,	 0,				 ScreenCentre - 80 + ResultsValue[5], 135);
	draw_sprite(spr_results_ringbonus,	 0,				 ScreenCentre - 80 + ResultsValue[6], 151);
	
	// Draw continue icon
	if ResultsValue[8] == 3 and ResultsValue[0] > -1
	{
		if ResultsValue[0] mod 32 <= 15
		{
			switch Game.Character
			{
				case CharSonic:
					var Icon = spr_obj_conticon_sonic;
				break;
				case CharTails:
					var Icon = spr_obj_conticon_tails;
				break;
				case CharKnuckles:
					var Icon = spr_obj_conticon_knuckles;
				break;
			}
			draw_sprite(Icon, (Stage.AnimationTime div 16) mod sprite_get_number(Icon), ScreenCentre + 96, 123);
		}
	}
	
	// Draw counters
	draw_set_font(Game.Font[Counter]);
	draw_set_halign(fa_right);
	
	draw_text(ScreenCentre + 80 + ResultsValue[4], 120, Player.Score);
	draw_text(ScreenCentre + 80 + ResultsValue[5], 136, TimeBonus);
	draw_text(ScreenCentre + 80 + ResultsValue[6], 152, RingBonus);
}