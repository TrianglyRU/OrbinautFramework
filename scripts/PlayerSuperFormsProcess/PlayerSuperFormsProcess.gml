function PlayerSuperFormsProcess()
{
	// Handle superform
	switch SuperState
	{	
		// Transformation start
		case 1:
		{
			// Count timer
			SuperStateValue++
			
			// Reset speeds for 16 frames
			if SuperStateValue < 16
			{
				Inertia = 0;
				Xsp		= 0;
				Ysp		= 0;	
			}
			
			// Restore inputs on 16th frame
			else if SuperStateValue == 16
			{
				AirLock = false;
			}
			
			// Become super on 40th (or 37th) frame
			else if SuperStateValue == 40 - (Game.Character != CharSonic) * 3
			{
				if Animation == AnimTransform
				{
					Animation = AnimMove;
				}
				SuperState		= 2;
				SuperStateValue = 1;
			}				
		}
		break;
		
		// Superform
		case 2:
		{
			// Decrease rings
			if Rings and !Death and !Drown
			{
				if (++SuperStateValue) == 61
				{
					SuperStateValue = 1;
					Rings--;
				}
			}
			
			// Create star particle (and make it follow the player)
			if abs(Inertia) >= TopAcc and !instance_exists(SuperStar)
			{
				var  Object = instance_create(PosX, PosY, SuperStar);
				with Object 
				{
					FollowPlayer = true;
				}
			}
			
			// Exit superform
			if !Rings
			{	
				if audio_bgm_is_playing(SuperMusic)
				{
					if Stage.IsBossfight
					{
						audio_bgm_play(PriorityLow, BossMusic, other);
					}
					else if HighspeedBonus
					{
						audio_bgm_play(PriorityLow, HighspeedMusic, noone);
					}
					else
					{
						audio_bgm_play(PriorityLow, Stage.StageMusic, other);
					}					
				}
				SuperStateValue = false;
				SuperState	    = false;
			}
		}
		break;
	}
	
	/* Process Super palettes */
	
	// Sonic palette
	if Game.Character == CharSonic
	{
		// Get current colour
		var Colour = palette_get_colour(PaletteDry, 1);
				
		// Regular form
		if !Player.SuperState
		{
			if Colour == 1
			{
				palette_set_colour(PaletteDry, 1, 4, 1);
				palette_set_colour(PaletteWet, 1, 4, 1);
			}
			else
			{
				if Colour < 17
				{
					palette_set_colour(PaletteDry, 1, 4, 17);
					palette_set_colour(PaletteWet, 1, 4, 17);
				}	
				palette_handle(PaletteDry, 1, 4, 21, 1, 4);
				palette_handle(PaletteWet, 1, 4, 21, 1, 4);	
			}
		}
				
		// Transforming into Super form
		else if Player.SuperState == 1
		{
			if Colour == 1
			{
				palette_handle(PaletteDry, 1, 4, 2, 2, 19);
				palette_handle(PaletteWet, 1, 4, 2, 2, 19);
			}
			if Colour > 1
			{
				palette_handle(PaletteDry, 1, 4, 6, 6, 4);
				palette_handle(PaletteWet, 1, 4, 6, 6, 4);
			}
		}
					
		// Super form
		else if Player.SuperState == 2
		{
			if Colour < 7
			{
				palette_set_colour(PaletteDry, 1, 4, 7);
				palette_set_colour(PaletteWet, 1, 4, 7);
			}
			palette_handle(PaletteDry, 1, 4, 16, 7, 8);
			palette_handle(PaletteWet, 1, 4, 16, 7, 8);
		}
	}
		
	// Tails palette
	else if Game.Character == CharTails
	{
		// Get current colour
		var Colour = palette_get_colour(PaletteDry, 5);
				
		// Regular form
		if !Player.SuperState
		{	
			if Colour == 1
			{
				palette_set_colour(PaletteDry, 5, 4, 1);
				palette_set_colour(PaletteWet, 5, 4, 1);
			}
			else
			{			
				palette_handle(PaletteDry, 5, 4, 6, 1, 12);
				palette_handle(PaletteWet, 5, 4, 6, 1, 12);
			}
		}
				
		// Super form
		else
		{
			if Colour == 1
			{
				palette_handle(PaletteDry, 5, 4, 1, 2, 28);
				palette_handle(PaletteWet, 5, 4, 1, 2, 28);
			}
			if Colour > 1
			{
				palette_handle(PaletteDry, 5, 4, 7, 2, 12);
				palette_handle(PaletteWet, 5, 4, 7, 2, 12);
			}
		}
	}
		
	// Knuckles palette
	else if Game.Character == CharKnuckles
	{
		// Get current colour
		var Colour = palette_get_colour(PaletteDry, 9);
				
		// Regular form
		if !Player.SuperState
		{
			if Colour == 1
			{
				palette_set_colour(PaletteDry, 9, 3, 1);
				palette_set_colour(PaletteWet, 9, 3, 1);
			}
			else
			{			
				palette_handle(PaletteDry, 9, 3, 11, 1, 3);
				palette_handle(PaletteWet, 9, 3, 11, 1, 3);	
			}
		}
			
		// Super form
		else
		{
			if Colour == 1
			{
				palette_handle(PaletteDry, 9, 3, 1, 3, 17);
				palette_handle(PaletteWet, 9, 3, 1, 3, 17);
			}
			if Colour == 2
			{
				palette_handle(PaletteDry, 9, 3, 2, 3, 15);
				palette_handle(PaletteWet, 9, 3, 2, 3, 15);
			}
			if Colour > 2
			{
				palette_handle(PaletteDry, 9, 3, 11, 2, 3);
				palette_handle(PaletteWet, 9, 3, 11, 2, 3);
			}
		}		
	}
}