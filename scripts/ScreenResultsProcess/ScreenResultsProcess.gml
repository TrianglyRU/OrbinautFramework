function ScreenResultsProcess()
{
	/* Value table
	---------------
	Value[0] - Timer (pre-results)
	Value[1] - Head PosX
	Value[2] - 'CHARACTER' PosX
	Value[3] - 'GOT THROUGH' PosX
	Value[4] - 'SCORE' PosX
	Value[5] - 'TIME' PosX
	Value[6] - 'RINGS' PosX
	Value[7] - Timer (post-results)
	Value[8] - ACT PosX
	
	TODO: Огранизовать массив 
	
	*/
	
	// Display only when act is finished
	if Stage.IsFinished
	{	
		if !ResultValue[0]
		{
			// Calculate ring bonus
			RingBonus = Player.Rings * 100;

			// Calculate time bonus
			if Stage.Time >= 35940
			{
				TimeBonus = 10000;
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
		}
		
		if ResultValue[0] < 300
		{
			ResultValue[0]++;
		}
		else
		{
			if ResultValue[0] == 300
			{
				audio_sfx_play(sfxScoreCount, true);
				ResultValue[0]++;
			}
			if Input.StartPress
			{
				Player.Score += TimeBonus + RingBonus;
				TimeBonus = 0; 
				RingBonus = 0;
			}
			if TimeBonus
			{ 
				TimeBonus -= 100;
				Player.Score += 100;
			}
			if RingBonus
			{
				RingBonus -= 100;
				Player.Score += 100;
			}
			if TimeBonus == 0 and RingBonus == 0 and ResultValue[0] == 301
			{
				audio_sfx_play(sfxScoreTally, false);
				audio_sfx_stop(sfxScoreCount);
				ResultValue[0]++;
			}
		}
		if ResultValue[2]
		{
			ResultValue[2] -= 20;
		}
		else if ResultValue[3]
		{
			ResultValue[3] -= 20;
		}
		else if ResultValue[8]
		{
			if ResultValue[1]
			{
				ResultValue[1] -= 20;
			}
			ResultValue[8] -= 20;
		}
		else
		{		
			if ResultValue[4]
			{
				ResultValue[4] -= 20;
			}
			if ResultValue[5] 
			{
				ResultValue[5] -= 20;
			}
			if ResultValue[6] 
			{
				ResultValue[6] -= 20;
			}
		}
		
		// Get screen centre
		var ScreenCentre = Game.ResolutionWidth / 2
		
		draw_set_font(Game.Font[FontDigits1]);
		draw_set_halign(fa_right);

		draw_sprite(spr_results_head, Player.CharacterID, ScreenCentre + 53 + ResultValue[1], 87);
		draw_sprite(spr_results_act,  Stage.ActID,        ScreenCentre + 25 + ResultValue[8], 78);
		
		draw_sprite(spr_results_char,		 Player.CharacterID, ScreenCentre - ResultValue[2] - 14, 60);
		draw_sprite(spr_results_through,	 0,					 ScreenCentre - ResultValue[3] - 15, 80);
		draw_sprite(spr_results_score,		 0,					 ScreenCentre - 80 + ResultValue[4], 119);
		draw_sprite(spr_results_timebonus,	 0,					 ScreenCentre - 80 + ResultValue[5], 135);
		draw_sprite(spr_results_ringbonus,	 0,					 ScreenCentre - 80 + ResultValue[6], 151);
		
		draw_text(ScreenCentre + 80 + ResultValue[4], 120, Player.Score);
		draw_text(ScreenCentre + 80 + ResultValue[5], 136, TimeBonus);
		draw_text(ScreenCentre + 80 + ResultValue[6], 152, RingBonus);
		
		// Perform fade out
		if TimeBonus == 0 and RingBonus == 0
		{
			// Count timer
			if (++ResultValue[7]) == 120
			{
				fade_perform(FadeTo, FadeBlack, 1);
			}
		}
	}
}