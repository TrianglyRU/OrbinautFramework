function ObjItemcardScript()
{
	// Exit if no item card assigned
	if (BoxType == "Empty") exit;
	
	// Exit the code if item card does not exist
	if (!instance_exists(ItemCard)) exit;
	
	// Check if monitor is not destroyed
	if !Destroyed
	{
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
						
						// Play sound, switch left and right channels every ring
						audio_sfx_play(sfx10Rings, false, true);
					}
					break;
					case "High Speed":
					{
						// Give highspeed bonus for 20 seconds
						Player.HighSpeedBonus = 1200;
					}
					break;
					case "Regular Barrier":
					{
						// Give regular shield
						Player.ShieldType = BarrierNormal;
					}
					break;
					case "Invincibility":
					{
						// Give invincibility bonus for 20 seconds
						Player.InvincibilityBonus = 1200;
					}
					break;
					case "Extra Life":
					{
						// Give player 1 extra life
						Player.Lives += 1;
						
						// Play sound
						audio_sfx_play(sfxSonic1UP, false, true);
					}
					break;
				}
			}
			
			// Destroy card after 32 frames
			ItemCardTimer++;
			if ItemCardTimer > 32
			{
				ItemCard.image_alpha -= 0.1;
				if ItemCard.image_alpha == 0
				{
					instance_destroy(ItemCard);
				}
			}
		}
	}
	
	// Update card position
	ItemCard.x = x;
	ItemCard.y = floor(ItemCardPosY);
}