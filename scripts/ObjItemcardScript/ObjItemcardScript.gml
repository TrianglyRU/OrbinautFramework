function ObjItemcardScript()
{
	// Exit if no item card assigned
	if BoxType == "Empty"
	{
		exit;
	}
	
	// Exit the code if item card does not exist
	if !instance_exists(ItemCard)
	{
		exit;
	}
	
	// Check if monitor is not destroyed
	if !Destroyed
	{
		// Reset object when off-screen
		//object_reset(RangeFar);
		
		// Count timer
		ItemCardTimer++
		
		// Hide every 4th frame
		if ItemCardTimer mod 4 == 0
		{
			ItemCard.image_alpha = 0;
		}
		
		// Show back every 6th frame
		else if ItemCardTimer mod 6 == 0
		{
			ItemCard.image_alpha = 1.0;
		}
		
		// Limit timer
		ItemCardTimer = ItemCardTimer mod 6;
		
		// Keep card on the same y as itembox
		ItemCardPosY = y - 4;
	}
	
	// Check if monitor is destroyed but card is not released yet
	else if !ItemCardRel
	{	
		// Reset timer
		ItemCardTimer = 0;
		
		// Set card speed
		ItemCardYsp	= -3;
		
		// Make card visible
		ItemCard.image_alpha = 1.0;
		
		// Render above everything
		ItemCard.depth = 0;
		
		// Set release flag
		ItemCardRel = true;
	}
	
	// Check if card is released
	else
	{
		// Move it until its speed is 0
		if ItemCardYsp != 0
		{
			ItemCardYsp  += 0.09375;
			ItemCardPosY += ItemCardYsp;
		}
		
		// Check if it is stopped
		else
		{
			// Give bonus
			if !ItemCardTimer
			{
				switch BoxType
				{
					case "10 Rings":
					{
						// Give 10 rings
						Player.Rings += 10;
						
						// Give extra life
						if Player.Rings >= 100 and Player.LivesRewards == 0
						or Player.Rings >= 200 and Player.LivesRewards == 1
						{
							Player.Lives++;
							Player.LivesRewards++;
							audio_bgm_play(Jingle1UP, -1, TypeJingle);
						}
						
						// Play sound, switch left and right channels every ring
						audio_sfx_play(Player.Rings mod 2 == 0 ? sfxRingLeft : sfxRingRight, false);
					}
					break;
					case "High Speed":
					{
						// Give highspeed bonus for 20 seconds
						Player.HighSpeedBonus = 1200;
						
						// Play music
						if !Player.SuperState
						{
							audio_bgm_play(HighspeedMusic, -1, TypePriority);
						}
					}
					break;
					case "Regular Barrier":
					{
						Player.BarrierType = BarrierNormal;
						audio_sfx_play(sfxBarrier, false);
						
						// Spawn barrier object
						if !instance_exists(Barrier)
						{
							instance_create(floor(Player.PosX), floor(Player.PosY), Barrier);
						}
					}
					break;
					case "Flame Barrier":
					{
						Player.BarrierType = BarrierFlame;
						audio_sfx_play(sfxFlameBarrier, false);
						
						// Spawn barrier object
						if !instance_exists(Barrier)
						{
							instance_create(floor(Player.PosX), floor(Player.PosY), Barrier);
						}
					}
					break;
					case "Thunder Barrier":
					{
						Player.BarrierType = BarrierThunder;
						audio_sfx_play(sfxThunderBarrier, false);
						
						// Spawn barrier object
						if !instance_exists(Barrier)
						{
							instance_create(floor(Player.PosX), floor(Player.PosY), Barrier);
						}
					}
					break;
					case "Water Barrier":
					{
						Player.BarrierType = BarrierWater;
						audio_sfx_play(sfxWaterBarrier, false);
						
						// Spawn barrier object
						if !instance_exists(Barrier)
						{
							instance_create(floor(Player.PosX), floor(Player.PosY), Barrier);
						}
					}
					break;
					case "Invincibility":
					{
						if !Player.SuperState
						{
							// Give invincibility bonus for 20 seconds
							Player.InvincibilityBonus = 1200;
						
							// Play music
							audio_bgm_play(InvincibilityMusic, -1, TypePriority);
						}
					}
					break;
					case "Extra Life":
					{
						// Give player 1 extra life
						Player.Lives += 1;
						
						// Play jingle
						audio_bgm_play(Jingle1UP, -1, TypeJingle);
					}
					break;
					case "Eggman":
					{
						object_damage(false, false, false, false);
					}
					break;
				}
			}
			
			// Destroy card after 32 frames
			ItemCardTimer++;
			if ItemCardTimer > 32
			{
				instance_destroy(ItemCard);
			}
		}
	}
	
	// Update card position
	ItemCard.x = x;
	ItemCard.y = floor(ItemCardPosY);
}