function ScreenResultsDisplay()
{
	if Stage.State = ActStateFinished
	{
		if (ResultValue[0] < 90) ResultValue[0] += 3;
		if Stage.StateTimer >= 60
		{
			//if (ResultValue[0] > 0) ResultValue[0] -= 5;
		}
		
		if Stage.StateTimer = 80
		{
			Stage.StateTimer = 0;
			Stage.State		 = ActStateUnload;
		}
		
		var CardFrm = ResultValue[0] / 90;
		var CenterPos = Game.ResolutionWidth div 2
		draw_sprite_ext(sprHUD_ResultsCard, 0, CenterPos + 68, 96, CardFrm, CardFrm, 90 - ResultValue[0], c_white, CardFrm);
		draw_sprite_ext(sprHUD_ResultsAct, Stage.ActID, CenterPos + 76, 96, CardFrm, 1, 0, c_white, 1);
		draw_sprite(sprHUD_ResultsThrought, 0, CenterPos, 96);
		draw_sprite(sprHUD_ResultsChar, Player.CharacterID, CenterPos, 62);
	}
}