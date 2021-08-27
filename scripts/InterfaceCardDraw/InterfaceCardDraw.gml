function InterfaceCardDraw()
{
	// TODO: SIMPLE TITLE CARD
	
	// If card sequence has ended, exit
	if CardValue[1] == 2
	{
		exit;
	}
	
	// If card is disabled, just fade in
	fade_perform(FadeFrom, ColourBlack, 1);	
	
	Input.IgnoreInput = false;
	Stage.TimeEnabled = true;
		
	CardValue[1] = 2;
}