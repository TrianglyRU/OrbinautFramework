/// @description Event
// You can write your code in this editor
	
	if !State
	{
		return;
	}
	
	if fade_check(StateMax)
	{
		global.BonusStageData[0] = Player.Rings;
		global.BonusStageData[1] = Player.BarrierType;
		
		// Send player to the Bonus Stage
		room_goto(BStage_Template);			
	}