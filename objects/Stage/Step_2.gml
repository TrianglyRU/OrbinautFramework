/// @description Process Stage / Objects
// You can write your code in this editor
	
	#region Process Gameplay
	{
		// Process stage timer
		if TimeEnabled
		{
			if (++Time) == 36000
			{
				player_damage(false, false, true);
			}	
		}
	
		// Process animated graphics
		if AnimatedGraphics != noone
		{	
			var Update  = Renderer.UpdateAnimations; 
			var Length  = array_length(AnimatedGraphics);
		        var GameFPS = game_get_speed(gamespeed_fps);
		
			for (var i = 0; i < Length; i += 2)
			{
				if Update
				{
					var AnimSpeed = GameFPS / AnimatedGraphics[i + 1];
				}
				else
				{
					var AnimSpeed = 0;
				}
				sprite_set_speed(AnimatedGraphics[i], AnimSpeed, spritespeed_framespersecond);
			}
		}

		// Process player's death event
		if Player.Death
		{
			Camera.Enabled = false;
			UpdateObjects  = false;
			TimeEnabled    = false;
		
			if !global.S3DeathRestart and floor(Player.PosY) >= Stage.BottomBoundary + 32
			or  global.S3DeathRestart and floor(Player.PosY) >= Camera.ViewY + global.Height + 32
			{
				if !RestartTimer
				{
					// If ran out of lives or time, start event
					if !(--Player.Lives) or Time == 36000
					{
						RestartEvent = true;
					
						audio_bgm_stop(AudioSecondary, 0);
						audio_bgm_play(AudioPrimary, GameOver);
					}
				}
				RestartTimer++;
			
				// Wait for 1 (or 12 if the event was triggered) seconds
				if RestartTimer == RestartEvent * 660 + 60
				{
					fade_perform(ModeInto, BlendBlack, 1);
				
					audio_bgm_stop(AudioPrimary,   0.5);
					audio_bgm_stop(AudioSecondary, 0.5);
			
					// Stop animations and background autoscrolling
					Renderer.UpdateAnimations = false;
				}
		
				// Wait until we fade out
				if fade_check(StateMax)
				{	
					if Player.Lives != 0
					{
						if array_length(global.StarPostData) and RestartEvent
						{
							// Clear saved time on the Star Post if we got time over'ed
							global.StarPostData[2] = 0;
						}
						global.Lives = Player.Lives;
					
						room_restart();
					}
					else
					{	
						global.SpecialRingList = [];
						global.StarPostData	   = [];
				
						if global.Continues
						{
							room_goto(Screen_Continue);
						}
						else
						{
							if global.ActiveSave != -1
							{
								// Re-write game data
								global.Lives     = 3;
								global.Score     = 0;
								global.Continues = 0;
							
								savedata_save(global.ActiveSave);
							}
							room_goto(Screen_DevMenu);
						}
					}
				}
			}
		}
	}
	#endregion
	
	#region Process Boundaries
	{
		if UpdateObjects
		{
			// Update left boundary
			if LeftBoundary < TargetLeftBoundary
			{
				if Camera.ViewX >= TargetLeftBoundary
				{
					LeftBoundary = TargetLeftBoundary
				}
				else
				{
					if Camera.ViewX >= LeftBoundary
					{
						LeftBoundary = Camera.ViewX
					}
					LeftBoundary = min(LeftBoundary + 2, TargetLeftBoundary);
				}
			}
			else if LeftBoundary > TargetLeftBoundary
			{
				LeftBoundary = max(TargetLeftBoundary, LeftBoundary - 2);
			}
	
			// Update right boundary
			if RightBoundary < TargetRightBoundary
			{
				RightBoundary = min(RightBoundary + 2, TargetRightBoundary)
			}
			else if RightBoundary > TargetRightBoundary
			{
				if Camera.ViewX + global.Width >= TargetRightBoundary
				{
					RightBoundary = Camera.ViewX + global.Width;
					RightBoundary = max(TargetRightBoundary, RightBoundary - 2);
				}
				else if Camera.ViewX + global.Width <= TargetRightBoundary
				{
					RightBoundary = TargetRightBoundary
				}
			}
	
			// Update top boundary
			if TopBoundary < TargetTopBoundary
			{
				if Camera.ViewY >= TargetTopBoundary
				{
					TopBoundary = TargetTopBoundary
				}
				else
				{
					if Camera.ViewY > TopBoundary
					{
						TopBoundary = Camera.ViewY;
					}
					TopBoundary = min(TopBoundary + 2, TargetTopBoundary);
				}
			}
			else if TopBoundary > TargetTopBoundary
			{
				TopBoundary = max(TargetTopBoundary, TargetTopBoundary - 2);
			}
	
			// Update bottom boundary
			if BottomBoundary < TargetBottomBoundary
			{
				BottomBoundary = min(BottomBoundary + 2, TargetBottomBoundary);
				DeathBoundary  = TargetBottomBoundary;
			}
			else if BottomBoundary > TargetBottomBoundary
			{
				if Camera.ViewY + global.Height >= TargetBottomBoundary
				{
					BottomBoundary = Camera.ViewY + global.Height
					BottomBoundary = max(TargetBottomBoundary, BottomBoundary - 2);
				}
				else if Camera.ViewY + global.Height <= TargetBottomBoundary
				{
					BottomBoundary = TargetBottomBoundary;
				}
				DeathBoundary = BottomBoundary;
			}
	
			// Keep boundaries within the room size
			TopBoundary    = max(0,			  TopBoundary);
			LeftBoundary   = max(0,			  LeftBoundary);
			RightBoundary  = min(room_width,  RightBoundary);
			BottomBoundary = min(room_height, BottomBoundary);
			DeathBoundary  = min(room_height, DeathBoundary);
		}
	}
	#endregion
	
	#region Process Objects
	{
		if UpdateObjects
		{
			/* Set active object bounds, accurate to the originals (if Width is set to 320px obviously, else adjusted). 
			If you decide to change that, also update instance_activate_range() */
			var LeftBound   = (Camera.ViewX & -128) - 128;
			var RightBound  = (Camera.ViewX & -128) + global.Width + 320;
	
			with all 
			{	
				switch Obj_UnloadType
				{
					// Destroy object
					case FlagDelete:
					{
						if x < LeftBound or x > RightBound or y > Stage.BottomBoundary or y < Stage.TopBoundary
						{
							instance_destroy();
						}
					}
					break;
					
					// Deactivate object
					case FlagPause:
					{
						if x < LeftBound or x > RightBound
						{
							if Obj_UnloadData[0] < LeftBound or Obj_UnloadData[0] > RightBound
							{
								instance_deactivate_object(id);
							}
						}
					}
					break;
					
					// Reset object
					case FlagReset:
					{
						if x < LeftBound or x > RightBound
						{
							if Obj_UnloadData[0] < LeftBound or Obj_UnloadData[0] > RightBound
							{
								// Reset data
								x			 = Obj_UnloadData[0];
								y			 = Obj_UnloadData[1];
								image_xscale = Obj_UnloadData[2];
								image_yscale = Obj_UnloadData[3];
								image_index  = Obj_UnloadData[4];
								sprite_index = Obj_UnloadData[5];
								visible      = Obj_UnloadData[6];
							
								// Reset animation data
								Obj_AnimDuration = 0;
								Obj_AnimTimer    = 0;
									
								// Perform create event to re-initialise variables and then deactivate object
								event_perform(ev_create, 0);
								instance_deactivate_object(id);
							}
							else
							{
								// Make object "disappear" until its initial position goes off-screen
								x = -128;
								y = -128;
								
								// Call Create event in case object is using its own variables for positioning
								event_perform(ev_create, 0);
							}
						}
					}
					break;
				}
			}
		}
	
		// Load objects (objects that were deactivated on this frame won't be activated!)
		instance_activate_range(Camera.ViewX);
	}
	#endregion
	
	#region Process Stage End
	{
		if IsFinished and fade_check(StateMax)
		{
			global.Score		   = Player.Score;
			global.Lives		   = Player.Lives;
			global.SpecialRingList = [];
			global.StarPostData	   = [];
	
			if SaveProgress and global.ActiveSave != -1
			{
				if IsFinalStage
				{
					// Mark savefile as completed if this was the last stage
					global.SaveState = 1;
				}
				else
				{
					global.ZoneID++;
				}
		
				// Save our progress
				savedata_save(global.ActiveSave);
			}

			// Load into the next stage
			if NextStage != noone
			{
				room_goto(NextStage);
			}
		}
	}
	#endregion
