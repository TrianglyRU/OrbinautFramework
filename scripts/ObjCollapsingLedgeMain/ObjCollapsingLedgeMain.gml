function ObjCollapsingLedgeMain()
{
	// Do collision
	object_act_solid(false, true, false, false);
	
	switch State
	{
		// Trigger ledge to collapse
		case 0:
		{
			if Player.OnObject == id
			{
				State = 1;
			}
		}
		break;
		
		// Collapse the ledge
		case 1:
		{
			if !(TimeDelay--)
			{
				// Play sound
				audio_sfx_play(sfxLedgeBreak, false);
				
				// Set how much time player can still be on the object
				TimeDelay = Width / 16 * 4 + Height / 16 * 2;
				
				// Spawn pieces
				var ThisObject = id;
				if  image_xscale
				{
					// Regular
					for (var i = Width - 16; i >= 0; i -= 16)
					{
						for (var j = Height - 16; j >= 0; j -= 16) 
						{
							var  Time   = abs(Width - i) / 16 * 4 + abs(Height - j) / 16 * 2;
							var  Object = instance_create(LeftX + i, TopY + j, CollapsingLedgePiece);
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
				}
				else
				{
					// Flipped
					for (var i = 16; i <= Width; i += 16) 
					{
						for (var j = Height - 16; j >= 0; j -= 16) 
						{
							var  Time = i / 16 * 4 + abs(Height - j) / 16 * 2;
							var  Object = instance_create(LeftX + i, TopY + j, CollapsingLedgePiece);
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
				}
				
				// Increment state
				State = 2;
			}
		}
		break;
		
		// Destroy object
		case 2:
		{
			if !(TimeDelay--)
			{
				instance_destroy();
				
				// Player should be now airbone
				Player.OnObject = false;
				Player.Grounded = false;
			}
		}
		break;
	}
}