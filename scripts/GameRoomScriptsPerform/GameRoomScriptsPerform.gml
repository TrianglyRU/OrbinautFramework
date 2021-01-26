function GameRoomScriptsPerform()
{
	switch room
	{	
		#region GameStart room
		case GameStart:
			
			// Disable fade
			Game.FadeEnabled = false;
			
			// Set loading Sonic object position
			objLoadingIcon.x = Game.ResolutionWidth - 24;
			objLoadingIcon.y = Game.ResolutionHeight - 24;	
			
			// Start a counter an proceed the next room
			Game.TempValue[0] += 1;
			if Game.TempValue[0] = 5 
			{
				Game.TempValue[0] = 0;
				room_goto_next();
			}
					
		break
		#endregion
			
	}
}