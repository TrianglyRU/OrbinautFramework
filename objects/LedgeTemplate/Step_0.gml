/// @description Main
// You can call your scripts in this editor
	
	// Do collision
	object_act_solid(false, true, false, false);
	
	switch State
	{
		case 0:
		{
			if object_check_player(ColSolidU)
			{
				// Increment state
				TimeDelay = 8;
				State    += 1;
			}
		}
		break;
		case 1:
		{
			if !(TimeDelay--)
			{
				var ThisObject = id;
				
				// Spawn pieces (non-mirrored)
				if image_xscale then for (var i = Width - 16; i >= 0; i -= 16)
				{
					for (var j = Height - 16; j >= 0; j -= 16) 
					{
						var  Time = i / 16 * 4 + abs(Height - j) / 16 * 2;
						var  Object = instance_create(OriginX + i, OriginY + j, LedgePiece);
						with Object
						{
							sprite_index = ThisObject.sprite_index;
							image_xscale = ThisObject.image_xscale;
								
							DrawX = i;
							DrawY = j;
							Timer = Time;
						}
					}
				}
				
				// Spawn pieces (mirrored)
				else for (var i = 16; i <= Width; i += 16) 
				{
					for (var j = Height - 16; j >= 0; j -= 16) 
					{
						var  Time   = abs(Width - i) / 16 * 4 + abs(Height - j) / 16 * 2;
						var  Object = instance_create(OriginX + i, OriginY + j, LedgePiece);
						with Object
						{
							sprite_index = ThisObject.sprite_index;                  
							image_xscale = ThisObject.image_xscale;
								
							DrawX = ThisObject.Width - i;
							DrawY = j;
							Timer = Time;
						}
					}
				}
				
				audio_sfx_play(sfxLedgeBreak, false);
				
				// Increment state
				TimeDelay = Width / 16 * 4 + Height / 16 * 2;
				State    += 1;
			}
		}
		break;
		case 2:
		{
			if !(TimeDelay--)
			{
				instance_destroy();
				
				// Player should be airborne now
				Player.OnObject = false;
				Player.Grounded = false;
			}
		}
		break;
	}