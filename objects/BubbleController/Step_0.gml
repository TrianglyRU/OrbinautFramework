/// @description Main
// You can write your code in this editor
	
	if Player.BarrierType == BarrierWater or Player.DebugMode or Stage.IsFinished
	{
		return;
	}
	
	// Emit a bubble each second
	if Player.AirTimer
	{
		if !(Player.AirTimer mod 60) and Player.AirTimer != 1800
		{
			// Mark bubble as the countdown one at certain moments
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
				IsCountBubble = true;
			}
		
			// Set a delay for a second bubble with 50% chance (allowing it to be generated)
			if irandom(1)
			{
				BubbleDelay = irandom_range(1, 16);
			}
		
			// Set type of the first bubble
			if BubbleDelay == -1
			{
				var ObjectType = IsCountBubble ? CountdownBubble : Bubble;
			}
			else
			{
				// Spawn as the countdown bubble with 25% chance, else spawn as a normal bubble
				var ObjectType = IsCountBubble and !irandom(3) ? CountdownBubble : Bubble;
			}
		
			// Generate the first bubble
			var  CountSprite = CountdownSprite;
			var  NewObject   = instance_create(Player.PosX + 6 * Player.Facing, Player.PosY, ObjectType);
			with NewObject
			{
				if ObjectType == CountdownBubble
				{
					sprite_index = CountSprite;
					image_index  = 0;
				}
				else
				{
					animation_play(sprite_index, 15, 6);
				}
				Direction = Player.Facing;
			}
			
			// Reset type
			if ObjectType == CountdownBubble
			{
				IsCountBubble = false;
			}
		}
	
		// Generate the second bubble
		if BubbleDelay != -1
		{
			if !BubbleDelay
			{
				var  CountSprite = CountdownSprite;
				var  ObjectType  = IsCountBubble ? CountdownBubble : Bubble;
				var  NewObject   = instance_create(Player.PosX + 6 * Player.Facing, Player.PosY, ObjectType);
				with NewObject
				{
					if ObjectType == CountdownBubble
					{
						sprite_index = CountSprite;
						image_index  = 0;
					}
					else
					{
						animation_play(sprite_index, 15, 6);
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
	
	// Emit bubbles when the player has drowned
	else if DrownBubbles < 12
	{
		// Initial delay
		if !DrownBubbles and DrownDelay == -1
		{
			DrownDelay = irandom(15);
		}
		
		if !(DrownDelay--)
		{
			var  Random    = irandom(3);
			var  NewObject = instance_create(Player.PosX + 6 * Player.Facing, Player.PosY - 12, Bubble);
			with NewObject
			{
				// Mark bubble as small with 75% chance
				BubbleType = Random ? 0 : 1;
				Direction  = Player.Facing;
				
				object_set_depth(Player, 1);
				animation_play(sprite_index, 15, 6);
			}
			DrownBubbles++;
			DrownDelay = irandom_range(1, 8);
		}
	}