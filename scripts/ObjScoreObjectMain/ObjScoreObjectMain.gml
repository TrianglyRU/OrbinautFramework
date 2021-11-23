function ObjScoreObjectMain()
{
	// Give points
	switch State
	{
		case 0:
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
			
			// Increment state
			State++;
		}
		break;
	}
	
	// Apply frame
	image_index = SpriteFrame;
	
	// Move object
	PosY += Ysp;
	Ysp  += 0.09375;
	
	// Update position
	y = floor(PosY);
	
	// Delete object if its speed has reached 0
	if Ysp == 0
	{
		instance_destroy();
	}
}