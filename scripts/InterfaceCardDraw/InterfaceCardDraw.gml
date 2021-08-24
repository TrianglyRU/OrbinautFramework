function InterfaceCardDraw()
{
	/* Now this is probably the worst code in Orbinaut,
	we're so sorry xd */
	
	// If card sequence has ended, exit
	if CardValue[1] == 2
	{
		exit;
	}
	
	// If card is disabled, just fade in
	if !Stage.CardEnabled
	{
		fade_perform(FadeFrom, ColourBlack, 1);	
		Input.IgnoreInput = false;
		Stage.TimeEnabled = true;
		
		CardValue[1] = 2;
		exit;
	}
	
	// Exit if stage is paused
	if Stage.IsPaused
	{
		exit;
	}
	
	// Turn screen into black
	if !CardValue[0]
	{
		fade_perform(FadeTo, ColourBlack, 0);
	}
	
	// Set text align
	draw_set_halign(fa_right);
	
	// Draw bottom line and note
	draw_sprite(gui_card_line, Game.Character, CardValue[5],	  CardValue[6]);
	draw_sprite(gui_card_note, 0,			   CardValue[5] - 46, CardValue[6] + 34);
	
	// Draw stage composition name
	switch Stage.StageMusic
	{
		case TestStageMusic:
			var CompositionName = "TEAM MEGAMIX - SPECIAL STAGE";
		break;
		default:
			var CompositionName = "NO INFORMATION";
		break;
	}
	draw_set_font(Game.Font[font_default]);
	draw_text(CardValue[5] - 52, CardValue[6] + 40, CompositionName);
	
	// Draw other card elements
	draw_sprite(gui_card_ribbon,	0,			 CardValue[2],      CardValue[3]);
	draw_sprite(gui_card_logo,	    0,			 CardValue[2] - 46, 24);
	draw_sprite(gui_card_zoneline,  0,			 CardValue[10],     CardValue[11]);
	draw_sprite(gui_card_act,       Stage.ActID, CardValue[12],	    CardValue[13]);
	
	// Draw zone name
	draw_set_font(Game.Font[font_card]);
	draw_text(CardValue[14], CardValue[15], Stage.ZoneName);
	
	// Process timer
	CardValue[0]++;
	
	// Appear state
	if CardValue[1] == 0
	{
		// Update ribbon speed
		CardValue[4] = max(CardValue[4] - 0.05, 0.15);
	
		// Update ribbon position
		CardValue[2] += CardValue[4];
		CardValue[3] += 2;
		
		// Loop ribbon vertically
		if CardValue[3] == 32
		{
			CardValue[3] -= 32;
		}
		
		// Update line speed
		if CardValue[5] > Game.Width
		{
			CardValue[7] = 0;
		}
		CardValue[9] += 2;
		CardValue[8] = dsin(CardValue[9]) / 10;
	
		// Update line position
		CardValue[5] += CardValue[7];
		CardValue[6] += CardValue[8];
	
		// Continue after 30 frames
		if CardValue[0] < 30 
		{
			exit;
		}
		
		// Update Zoneline position
		if CardValue[10] > 60
		{
			CardValue[10] = max(60, CardValue[10] - 32);
		}
		else
		{
			CardValue[10] -= 0.2;
		}
		CardValue[11] -= 0.05;
		
		// Update act vertical position
		CardValue[13] -= 0.05;
		
		// Update text vertical position
		CardValue[15] -= 0.05;
	
		// Continue after 50 frames
		if CardValue[0] < 50
		{
			exit;
		}
		
		// Update act x position
		CardValue[12] = CardValue[12] > Game.Width - 120 ? CardValue[12] - 16  : CardValue[12] - 0.1;
		
		// Update text x position
		CardValue[14] = CardValue[14] < Game.Width - 84  ? CardValue[14] + 24 : CardValue[14] + 0.1;
		
		// Fade in after 3 seconds
		if CardValue[0] == 180
		{	
			fade_perform(FadeFrom, ColourBlack, 1);	
			Input.IgnoreInput = false;
			Stage.TimeEnabled = true;
			
			// Increment state
			CardValue[1] = 1;
		}
	}
	
	// Disappear state
	else if CardValue[1] == 1
	{
		// Keep assets on the screen for a bit
		CardValue[10] -= 0.2;
		CardValue[11] -= 0.05;
		CardValue[12] -= 0.1;
		CardValue[13] -= 0.05;
		CardValue[14] += 0.1;
		CardValue[15] -= 0.05;
		CardValue[2]  += 0.15;
		CardValue[3]  += 2;
		
		// Update global disappear speed
		CardValue[16] += 0.2;
		
		if CardValue[0] > 205
		{
			CardValue[2] -= CardValue[16];
		}	
		if CardValue[0] > 220
		{	
			CardValue[10] += CardValue[16] * 6;
			CardValue[14] += CardValue[16] * 6;
			CardValue[12] -= CardValue[16] * 6;
		}
		CardValue[6] += CardValue[16];
		
		// End card sequence
		if CardValue[0] == 235
		{
			CardValue[1]	 = 2;
		}
	}
}