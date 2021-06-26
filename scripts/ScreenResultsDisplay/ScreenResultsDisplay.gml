function ScreenResultsDisplay()
{
	// Display only when act is finished and one second passed or act unloads
	if Stage.IsFinished and Stage.StateTimer == -1
	{	
		if !ResultValue[0]
		{
			// Calculate ring bonus
			RingBonus = Player.Rings * 100;

			// Calculate time bonus
			if (Stage.Time >= 1800 and Stage.Time < 2700) TimeBonus = 10000;
			else
			{
				switch Stage.Time div 1800
				{
					case 0:			TimeBonus = 5000; break;
					case 1:			TimeBonus = 5000;  break;
					case 2:			TimeBonus = 4000;  break;
					case 3:			TimeBonus = 3000;  break;
					case 4: case 5: TimeBonus = 2000;  break;
					case 6: case 7: TimeBonus = 1000;  break;
					case 8: case 9: TimeBonus = 500;   break;
					default:		TimeBonus = 0;	   break;
				}
			}
		}
		
		if (ResultValue[0] < 300) ResultValue[0]++;
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
		
		if (ResultValue[2]) ResultValue[2] -= 20;
		else 
		if (ResultValue[3]) ResultValue[3] -= 20;
		else 
		{
			if (ResultValue[1] < 90) ResultValue[1] += 5;	
			if (ResultValue[4]) ResultValue[4] -= 20;
			if (ResultValue[5]) ResultValue[5] -= 20;
			if (ResultValue[6]) ResultValue[6] -= 20;
		}
		
		var CardFrm   = ResultValue[1] / 90;
		var CenterPos = Game.ResolutionWidth / 2
		
		draw_set_font(Game.Font[FontDigits1]);
		draw_set_halign(fa_right);

		draw_sprite_ext(spr_results_head, 0, CenterPos + 60, 96, CardFrm, CardFrm, 90 - ResultValue[1], c_white, CardFrm);
		draw_sprite_ext(spr_results_act, Stage.ActID, CenterPos + 68, 96, CardFrm, 1, 0, c_white, 1);
		draw_sprite(spr_results_char, Player.CharacterID, CenterPos - ResultValue[2], 62);
		draw_sprite(spr_results_through, 0, CenterPos   - ResultValue[3], 96);
		draw_sprite(spr_results_head_small, 0, CenterPos - 44 + ResultValue[4], 118);
		draw_sprite(spr_hud_score,		 0, CenterPos - 80 + ResultValue[4], 120);
		draw_text(CenterPos + 80 + ResultValue[4], 120, Player.Score);
		draw_sprite(spr_results_head_small, 0, CenterPos - 6  + ResultValue[5], 134);
		draw_sprite(spr_results_timebonus,	 0, CenterPos - 80 + ResultValue[5], 136);
		draw_text(CenterPos + 80 + ResultValue[5], 136, TimeBonus);
		draw_sprite(spr_results_head_small, 0, CenterPos - 6  + ResultValue[6], 150);
		draw_sprite(spr_results_ringbonus,	 0, CenterPos - 80 + ResultValue[6], 152);
		draw_text(CenterPos + 80 + ResultValue[6], 152, RingBonus);
		
		// Unload the act
		if TimeBonus == 0 and RingBonus == 0 and Stage.State != ActStateUnload
		{
			ResultsTimer++;
			
			if ResultsTimer == 120
			{
				ResultsTimer     = 0;
				Stage.StateTimer = 0;
				Stage.State		 = ActStateUnload;
			}
		}
	}
}