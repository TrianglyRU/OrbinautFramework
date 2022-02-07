function ObjStarPostPortalEvent()
{
	if !State
	{
		return;
	}
	
	if fade_check(StateMax)
	{
		Game.BonusStageData[0] = Player.Rings;
		Game.BonusStageData[1] = Player.BarrierType;
		
		// Send player to the Bonus Stage
		room_goto(BStage_Template);			
	}	
}