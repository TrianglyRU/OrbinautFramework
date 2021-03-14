function ScreenResultsDisplay()
{
	// Display only when act is finished and one second passed or act unloads
	if Stage.State = ActStateFinished and Stage.StateTimer = -1
	or Stage.State = ActStateUnload
	{
		if (ResultValue[0] < 90) ResultValue[0] += 3;
		
		var CardFrm   = ResultValue[0] / 90;
		var CenterPos = Screen.RenderX + Game.ResolutionWidth / 2
		var drawY     = Screen.RenderY;
		
		draw_sprite_ext(sprHUD_ResultsCard, 0, CenterPos + 68, drawY + 96, CardFrm, CardFrm, 90 - ResultValue[0], c_white, CardFrm);
		draw_sprite_ext(sprHUD_ResultsAct, Stage.ActID, CenterPos + 76, drawY + 96, CardFrm, 1, 0, c_white, 1);
		draw_sprite(sprHUD_ResultsThrought, 0, CenterPos, drawY + 96);
		draw_sprite(sprHUD_ResultsChar, Player.CharacterID, CenterPos, drawY + 62);
		
		// Unload the act after 80 ticks
		ResultValue[1]++;
		if ResultValue[1] = 80
		{
			Stage.StateTimer = 0;
			Stage.State		 = ActStateUnload;
		}
	}
}