/// @description
// You can write your code in this editor
	
	// Exit if player has water barrier
	if Player.BarrierType == BarrierWater
	{
		exit;
	}
	
	// Emit a bubble normally
	if !Player.Drown
	{
		if !(Player.AirTimer mod 60) or Player.AirTimer <= 720 and !(Player.AirTimer mod 120)
		{
			// Check if bubble should be a counter
			if Player.AirTimer <= 720 and !(Player.AirTimer mod 120)
			{
				switch Player.AirTimer div 120
				{
					case 6:
						CounterSprite = spr_obj_bubble_number5;
					break;
					case 5:
						CounterSprite = spr_obj_bubble_number4;
					break;
					case 4:
						CounterSprite = spr_obj_bubble_number3;
					break;
					case 3:
						CounterSprite = spr_obj_bubble_number2;
					break;
					case 2:
						CounterSprite = spr_obj_bubble_number1;
					break;
					case 1:
						CounterSprite = spr_obj_bubble_number0;
					break;
				}
				CounterBubble = true;
			}
		
			// Set a chance to generate second bubble	
			if irandom(1)
			{
				BubbleDelay = irandom_range(1, 16);
			}
		
			// Set a type of first bubble
			if !BubbleDelay
			{
				var Type = CounterBubble ? CountdownBubble : Bubble;
			}
			else
			{
				var Type = CounterBubble and !irandom(3) ? CountdownBubble : Bubble;
			}
		
			// Create first bubble
			var  Sprite = CounterSprite;
			var  Object = instance_create(floor(Player.PosX + 6 * Player.Facing), floor(Player.PosY), Type);
			with Object
			{
				if Type == CountdownBubble
				{
					animation_set_frame(Sprite, 1);
				}
				Direction = Player.Facing;
			}
			if Type == CountdownBubble
			{
				CounterBubble = false;
			}
		}
	
		// Create second bubble
		if BubbleDelay != -1
		{
			if !BubbleDelay
			{
				var  Sprite  = CounterSprite;
				var  Type    = CounterBubble ? CountdownBubble : Bubble;
				var  Object  = instance_create(floor(Player.PosX + 6 * Player.Facing), floor(Player.PosY), Type);
				with Object
				{
					if Type == CountdownBubble
					{
						animation_set_frame(Sprite, 1);
					}
					Direction = Player.Facing;
				}
				CounterBubble = false;
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
			var  Object = instance_create(floor(PosX + 6 * Player.Facing), floor(Player.PosY - 12), Bubble);
			with Object
			{
				BubbleType = Random ? 0 : 1;
				Direction  = Player.Facing;
				
				// Override depth
				object_set_depth(Player, true);
			}
			DrownBubbles++;
			DrownDelay = irandom_range(1, 8);
		}
	}