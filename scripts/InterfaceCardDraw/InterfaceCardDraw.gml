function InterfaceCardDraw()
{
	/* Value Table Reference
	------------------------
	Value[0] - Timer
	Value[1] - State
	Value[2] - Ribbon Y
	Value[3] - Ribbon X
	Value[4] - Logo X
	Value[5] - Logo Scale
	Value[6] - Act Number X
	Value[7] - Zone Name X
	------------------------
	*/
	
	// Exit if title card is in state 3
	if CardValue[1] == 3
	{
		exit;
	}
	
	switch CardValue[1]
	{
		// Appear
		case 0:
		{	
			// Increment state after a second
			if (++CardValue[0]) == 60
			{
				CardValue[0] = 0;
				CardValue[1] = 1;
			}
			else
			{
				// Move ribbon
				if (++CardValue[2] mod 16) == 0
				{
					CardValue[2] -= 16;
				}
				CardValue[3] = CardValue[3] + max(0, 6 - CardValue[0] / 8);
				
				// Move logo
				if CardValue[0] > 4
				{
					CardValue[4] = CardValue[4] + max(0, 6 - (CardValue[0] - 4) / 8);
				}
				
				// Move act number
				if CardValue[0] > 32
				{
					CardValue[6] = min(Game.Width - 96, CardValue[6] + 24);
				}
				
				// Move zone name
				if CardValue[0] > 24
				{
					CardValue[7] = max(Game.Width - 48, CardValue[7] - 24);
				}
			}
		}
		break;
		
		// Idle
		case 1:
		{
			// Increment state after two seconds
			if (++CardValue[0]) == 120
			{
				CardValue[0] = 0;
				CardValue[1] = 2;	
			}
			else
			{
				// Start gameplay
				if CardValue[0] == 60
				{
					Input.IgnoreInput = false;
					Stage.TimeEnabled = true;
					
					// Fade in
					fade_perform(FadeFrom, ColourBlack, 1);
				}
				
				// Move ribbon
				if (++CardValue[2] mod 16) == 0
				{
					CardValue[2] -= 16;
				}
			}
		}
		break;
		
		// Disappear
		case 2:
		{
			// Increment state after one second
			if (++CardValue[0]) == 60
			{
				CardValue[0] = 0;
				CardValue[1] = 3;	
			}
			else
			{
				// Move ribbon
				if (++CardValue[2] mod 16) == 0
				{
					CardValue[2] -= 16;
				}
				if CardValue[0] >= 16
				{
					CardValue[3] -= CardValue[0] / 4;
				}
				
				// Scale logo
				if CardValue[0] < 5
				{
					CardValue[5] += 0.05;
				}
				else if CardValue[5] > 0
				{
					CardValue[5] = max(CardValue[5] - 0.1, 0);
				}
				
				// Move zone name and act number
				if CardValue[0] >= 48
				{
					CardValue[6] -= 48;
					CardValue[7] += 24;
				}
			}
		}
		break;
	}
		
	// Draw ribbon
	draw_sprite(gui_card_ribbon, 0, floor(CardValue[3]), floor(CardValue[2]));
	
	// Draw logo
	draw_sprite_ext(gui_card_logo, 0, floor(CardValue[4]), Game.Height - 24, CardValue[5], CardValue[5], 0, c_white, 1);
	
	// Draw act number
	draw_sprite(gui_card_act, Stage.ActID, CardValue[6], Game.Height / 2 + 4);
			
	// Draw zone name
	draw_set_halign(fa_right);
	draw_set_font(game_font(font_card));
	draw_text(CardValue[7], Game.Height / 2 - 32, Stage.ZoneName);
}