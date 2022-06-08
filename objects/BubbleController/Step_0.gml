/// @description Main
// You can write your code in this editor
	
	if Player.DebugMode or Stage.IsFinished or !Player.IsUnderwater
	{
		instance_destroy(); return;
	}
	if Player.BarrierType == BarrierWater
	{
		return;
	}
	
	if Player.AirTimer > 0 and Player.AirTimer != 1800
	{
		// Emit a bubble each second
		if !(Player.AirTimer mod 60)
		{
			// Before we do that, check if the bubble should be the countdown one
			switch Player.AirTimer
			{
				case 720:
					CountdownSprite = spr_obj_bubble_number5;
					IsCountBubble   = true;
				break;
				case 600:
					CountdownSprite = spr_obj_bubble_number4;
					IsCountBubble   = true;
				break;
				case 480:
					CountdownSprite = spr_obj_bubble_number3;
					IsCountBubble   = true;
				break;
				case 360:
					CountdownSprite = spr_obj_bubble_number2;
					IsCountBubble   = true;
				break;
				case 240:
					CountdownSprite = spr_obj_bubble_number1;
					IsCountBubble   = true;
				break;
				case 120:
					CountdownSprite = spr_obj_bubble_number0;
					IsCountBubble   = true;
				break;
			}

			// Set a delay for a second bubble with 50% chance (allowing it to generate)
			if irandom(1)
			{
				BubbleDelay = irandom_range(1, 16);
			}
		
			// If one bubble should be generated, choose between normal and countdown one (depending on a flag set above)
			if BubbleDelay == -1
			{
				var ObjectType = IsCountBubble ? CountdownBubble : Bubble;
			}
			
			// If two bubbles should be generated, spawn the countdown one as the frist one with 25% chance
			else
			{
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
			
			// If the first bubble was the countdown one, reset the flag to make sure the second one will be the regular bubble
			if ObjectType == CountdownBubble
			{
				IsCountBubble = false;
			}
		}
	
		// Generate the second bubble with a delay
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