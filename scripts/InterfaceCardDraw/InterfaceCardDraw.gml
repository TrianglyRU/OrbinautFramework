function InterfaceCardDraw()
{
	// If card sequence has ended, exit
	if CardValue[1] == 2
	{
		exit;
	}
	
	// Set text align
	draw_set_halign(fa_right);
	
	// Draw colour line and note
	draw_sprite(spr_card_line, Player.CharacterID, CardValue[5],	   CardValue[6]);
	draw_sprite(spr_card_note, 0,				   CardValue[5] - 46, CardValue[6] + 34);
	
	// Display composition name
	switch Stage.StageMusic
	{
		case StarryNight:
			var CompositionName = "WOOFLE - STARRY NIGHT ZONE ACT 1";
		break;
		default:
			var CompositionName = "UNKNOWN TRACK";
		break;
	}
	draw_set_font(Game.Font[FontDebug]);
	draw_text(CardValue[5] - 52, CardValue[6] + 40, CompositionName);
	
	// Draw card elements
	draw_sprite(spr_card_ribbon,	0,			 CardValue[2],      CardValue[3]);
	draw_sprite(spr_card_logo,	    0,			 CardValue[2] - 46, 24);
	draw_sprite(spr_card_zoneline,  0,			 CardValue[10],     CardValue[11]);
	draw_sprite(spr_card_act,       Stage.ActID, CardValue[12],	    CardValue[13]);
	
	// Draw zone name
	draw_set_font(Game.Font[FontCard]);
	string_display(CardValue[14], CardValue[15], Stage.ZoneName, 1);
	
	// Turn screen into black
	if !CardValue[0]
	{
		fade_perform(FadeTo, FadeBlack, 0);
	}
	
	// Count card
	CardValue[0]++;
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
			fade_perform(FadeFrom, FadeBlack, 1);	
			CardValue[1]	  = 1;
			Input.IgnoreInput = false;
			Stage.TimeEnabled = true;
		}
	}
	else if CardValue[1] == 1
	{
		// Update elements positions
		CardValue[10] -= 0.2;
		CardValue[11] -= 0.05;
		CardValue[12] -= 0.1;
		CardValue[13] -= 0.05;
		CardValue[14] += 0.1;
		CardValue[15] -= 0.05;
		CardValue[2]  += 0.15;
		CardValue[3]  += 2;
		
		// Update disappear speed
		CardValue[16] += 0.2;
		
		// Disappear
		CardValue[6] += CardValue[16];
		
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
		
		// Shift HUD
		if CardValue[0] >= 235 and OffsetX < 0
		{
			OffsetX += 5;
		}
		
		// Stop card
		if CardValue[0] == 235
		{
			CardValue[1]	 = 2;
			Stage.AllowPause = true;
		}
	}
}