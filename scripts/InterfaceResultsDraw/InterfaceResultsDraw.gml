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
	Value[9] - Ring Bonus
	Value[10] - Time Bonus
	Value[11] - Continue flag
	---------------
	*/
	
	// Exit if act is not finished
	if Stage.IsFinished < 2
	{
		exit;
	}

	if Stage.DoUpdate
	{	
		// State 0
		if !ResultsValue[8]
		{
			// Calculate ring bonus
			ResultsValue[9] = Player.Rings * 100;
			
			// Calculate time bonus
			if Stage.Time >= 35940
			{
				ResultsValue[10] = 100000;
			}
			else if Stage.Time < 1800
			{
				ResultsValue[10] = 50000;
			}			
			else if Stage.Time >= 1800 and Stage.Time < 2700
			{
				ResultsValue[10] = 10000;
			}
			else
			{
				switch Stage.Time div 1800
				{
					case 0:			
						ResultsValue[10] = 5000; 
					break;
					case 1:			
						ResultsValue[10] = 5000;  
					break;
					case 2:			
						ResultsValue[10] = 4000;  
					break;
					case 3:			
						ResultsValue[10] = 3000;  
					break;
					case 4: 
					case 5: 
						ResultsValue[10] = 2000;  
					break;
					case 6: 
					case 7: 
						ResultsValue[10] = 1000;  
					break;
					case 8: 
					case 9: 
						ResultsValue[10] = 500;   
					break;
					default:
						ResultsValue[10] = 0;	  
					break;
				}
			}			
			
			// Check if we can get a reward
			ResultsValue[11] = ResultsValue[9] + ResultsValue[10] >= 10000
			
			// Increment state
			ResultsValue[8]++;
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
				else if ResultsValue[7]
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
					Player.Score += ResultsValue[10] + ResultsValue[9];
					ResultsValue[10] = 0; 
					ResultsValue[9] = 0;
				}
				else
				{
					// Count bonuses
					if ResultsValue[10]
					{ 
						ResultsValue[10]	 -= 100;
						Player.Score += 100;
					}
					if ResultsValue[9]
					{
						ResultsValue[9]    -= 100;
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
				if ResultsValue[10] == 0 and ResultsValue[9] == 0
				{
					audio_sfx_play(sfxScoreTally, false);
					audio_sfx_stop(sfxScoreCount);
					
					// If earned more than 10000 points, grant continue
					if ResultsValue[11]
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
				fade_perform(FadeTo, ColourBlack, 1);
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
				fade_perform(FadeTo, ColourBlack, 1);
			}
		}
	}
	
	// Get screen centre
	var ScreenCentre = Game.Width / 2
	
	// Draw assets
	draw_sprite(gui_results_head,	   Game.Character, ScreenCentre + 53 + ResultsValue[1], 87);
	draw_sprite(gui_results_char,	   Game.Character, ScreenCentre - 14 - ResultsValue[2], 60);
	draw_sprite(gui_results_act,	   Stage.ActID,    ScreenCentre + 46 + ResultsValue[7], 89);	
	draw_sprite(gui_results_through,   0,			   ScreenCentre - 15 - ResultsValue[3], 80);
	draw_sprite(gui_results_score,	   0,			   ScreenCentre - 58 + ResultsValue[4], 127);
	draw_sprite(gui_results_timebonus, 0,			   ScreenCentre - 38 + ResultsValue[5], 143);
	draw_sprite(gui_results_ringbonus, 0,			   ScreenCentre - 38 + ResultsValue[6], 159);
	
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
			draw_sprite(Icon, animate_sprite(2, 16), ScreenCentre + 96, 123);
		}
	}
	
	// Draw counters
	draw_set_font(Game.Font[font_counter]);
	draw_set_halign(fa_right);
	
	draw_text(ScreenCentre + 83 + ResultsValue[4], 125, Player.Score);
	draw_text(ScreenCentre + 83 + ResultsValue[5], 141, ResultsValue[10]);
	draw_text(ScreenCentre + 83 + ResultsValue[6], 157, ResultsValue[9]);
}