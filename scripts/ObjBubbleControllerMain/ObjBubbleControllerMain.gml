function ObjBubbleControllerMain()
{
	// Exit if any of this is happening
	if Player.BarrierType == BarrierWater or Player.DebugMode or Stage.IsFinished
	{
		exit;
	}
	
	// Emit a bubble normally each second
	if Player.AirTimer
	{
		if !(Player.AirTimer mod 60) and Player.AirTimer != 1800
		{
			// Check if bubble should be the countdown one
			if Player.AirTimer <= 720 and !(Player.AirTimer mod 120)
			{
				switch Player.AirTimer div 120
				{
					case 6:
						CountdownSprite = spr_obj_bubble_number5;
					break;
					case 5:
						CountdownSprite = spr_obj_bubble_number4;
					break;
					case 4:
						CountdownSprite = spr_obj_bubble_number3;
					break;
					case 3:
						CountdownSprite = spr_obj_bubble_number2;
					break;
					case 2:
						CountdownSprite = spr_obj_bubble_number1;
					break;
					case 1:
						CountdownSprite = spr_obj_bubble_number0;
					break;
				}
				
				// If so, set flag
				IsCountBubble = true;
			}
		
			// Generate a second bubble with 50% chance	
			if irandom(1)
			{
				BubbleDelay = irandom_range(1, 16);
			}
		
			// Set type of the first bubble
			if !BubbleDelay
			{
				var Type = IsCountBubble ? CountdownBubble : Bubble;
			}
			else
			{
				var Type = IsCountBubble and !irandom(3) ? CountdownBubble : Bubble;
			}
		
			// Create first bubble
			var  Sprite = CountdownSprite;
			var  Object = instance_create(Player.PosX + 6 * Player.Facing, Player.PosY, Type);
			with Object
			{
				if Type == CountdownBubble
				{
					sprite_index = Sprite;
					image_index  = 0;
				}
				Direction = Player.Facing;
			}
			if Type == CountdownBubble
			{
				IsCountBubble = false;
			}
		}
	
		// Create second bubble
		if BubbleDelay != -1
		{
			if !BubbleDelay
			{
				var  Sprite = CountdownSprite;
				var  Type   = IsCountBubble ? CountdownBubble : Bubble;
				var  Object = instance_create(Player.PosX + 6 * Player.Facing, Player.PosY, Type);
				with Object
				{
					if Type == CountdownBubble
					{
						sprite_index = Sprite;
						image_index  = 0;
					}
					Direction = Player.Facing;
				}
				IsCountBubble = false;
				BubbleDelay   = -1;
			}
			else
			{
				BubbleDelay--;
			}
		}
	}
	
	// Emit a bubble when drown
	else if DrownBubbles < 12
	{
		if !DrownBubbles and DrownDelay == -1
		{
			DrownDelay = irandom(15);
		}
		if !(DrownDelay--)
		{
			var  Random = irandom(3);
			var  Object = instance_create(Player.PosX + 6 * Player.Facing, Player.PosY - 12, Bubble);
			with Object
			{
				// Mark bubble as small with 75% chance
				BubbleType = Random ? 0 : 1;
				Direction  = Player.Facing;
				
				// Override depth
				object_set_depth(Player, true);
			}
			DrownBubbles++;
			DrownDelay = irandom_range(1, 8);
		}
	}
}