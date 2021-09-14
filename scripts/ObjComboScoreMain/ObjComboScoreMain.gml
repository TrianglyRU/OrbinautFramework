function ObjComboScoreMain()
{
	// Get 50000 score target
	var LifeReward = max(ceil(Player.Score / 50000) * 50000, 50000);
	
	// Give points
	if !PointsGiven
	{
		if ComboTrigger
		{	
			// 1 Hit
			if Player.ScoreCombo < 2
			{
				Player.Score += 100;
				SpriteFrame   = 1;
			}
			
			// 2 Hits
			else if Player.ScoreCombo < 3
			{
				Player.Score += 200;
				SpriteFrame   = 2;
			}
			
			// 3 Hits
			else if Player.ScoreCombo < 4
			{
				Player.Score += 500;
				SpriteFrame   = 3;
			}
			
			// 4 -> 15 Hits
			else if Player.ScoreCombo < 16
			{
				Player.Score += 1000;
				SpriteFrame   = 4;
			}
			
			// 16+ Hits
			else							
			{
				Player.Score += 10000;
				SpriteFrame   = 5;
			}
		}
		
		// Give 10 points if it is not combo score
		else
		{
			Player.Score += 10;
			SpriteFrame   = 0;
		}
		PointsGiven = true;
	}
	image_index = SpriteFrame;
	
	// Grant extra life for exceeding 50000 points
	if Player.Score >= LifeReward
	{
		Player.Lives++;
		audio_bgm_play(PriorityHigh, ExtraLifeJingle, noone);
	}
	
	// Move object
	Ysp  += 0.09375;
	PosY += Ysp;
	
	// Update position
	y = floor(PosY);
	
	// Delete object if it is stopped
	if Ysp == 0
	{
		instance_destroy();
	}
}