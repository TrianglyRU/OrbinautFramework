/// @description Process Camera
// You can write your code in this editor

	#region Process Follow
	{
		if Enabled and instance_exists(Target)
		{
			// Get target's position relative to camera
			if Target == Player
			{
				if Player.Spinning and Player.ClimbState != ClimbJump
				{
					var Offset = Player.DefaultRadiusY - Player.RadiusY;
				}
				else
				{
					var Offset = 0;
				}
				TargetX = floor(Player.PosX) - PosX;
				TargetY = floor(Player.PosY) - PosY - Offset;
			}
			else
			{
				TargetX = Target.x - PosX;
				TargetY = Target.y - PosY;
			}
	
			// Set horizontal shift speed
			if TargetX <= global.Width / 2 - 16 
			{ 
				ShiftX = clamp(TargetX - (global.Width / 2 - 16), -MaxShiftX, 0);  
			}
			else if TargetX >= global.Width / 2
			{ 
				ShiftX = clamp(TargetX - (global.Width / 2), 0, MaxShiftX);    
			}
			else
			{
				ShiftX = 0;
			}
	
			// Set vertical shift speed
			if Target == Player and Player.Grounded
			{	
				if abs(Player.Gsp) >= 8
				{
					var Limit = MaxShiftY;
				}
				else
				{
					var Limit = 6;
				}
				ShiftY = clamp(TargetY - (global.Height / 2 - 16), -Limit, Limit);
			} 
			else 
			{
				if TargetY <= global.Height / 2 - 48 
				{ 
					ShiftY = clamp(TargetY - (global.Height / 2 - 48), -MaxShiftY, 0);  
				} 
				else if TargetY >= global.Height / 2 + 16 
				{ 
					ShiftY = clamp(TargetY - (global.Height / 2 + 16), 0, MaxShiftY);  
				}
				else
				{
					ShiftY = 0;
				}
			}
	
			// Follow target
			if ScrollDelay
			{
				ScrollDelay--;
			}
			else
			{
				PosX += ShiftX;		
			}
			PosY += ShiftY;
		}
	}
	#endregion
	
	#region Update Offsets
	{
		// Shake the camera. Not quite accurate to originals, but somewhat close (we hope)
		if ShakeTime
		{
			ShakeX     = irandom_range(8, 15)    * choose(-1, 1) * (1 + ShakeTime / 6) / 128;
			ShakeY     = irandom_range(128, 255) * choose(-1, 1) * (1 + ShakeTime / 6) / 255;
			ShakeTime -= 1;
		}
		else
		{
			ShakeX = 0;
			ShakeY = 0;
		}
		
		if Enabled and instance_exists(Target) and Target == Player
		{
			// Offset camera horizontally, like in CD
			if global.CDCamera
			{
				var ScreenShift	= 64;	// <- default value for 320px width, which is floor(global.Width / 5)
		
				var ScreenSpeed    = floor(ScreenShift / 32);
				var ShiftDirection = Player.Gsp != 0 ? sign(Player.Gsp) : Player.Facing;
		
				if abs(Player.Gsp) >= 6 or Player.PeeloutRev >= 6 or Player.SpindashRev >= 0
				{
					if !ScrollDelay and ExtendedOffset != ScreenShift * ShiftDirection
					{
						ExtendedOffset += ScreenSpeed * ShiftDirection
					}
				}
				else
				{
					ExtendedOffset -= ScreenSpeed * sign(ExtendedOffset);
				}
			}
	
			// Check for overview delay
			var ShiftDown = Player.Animation == AnimCrouch;
			var ShiftUp   = Player.Animation == AnimLookup;
	
			if (ShiftUp or ShiftDown) and !Player.DebugMode
			{
				if OverviewDelay
				{
					OverviewDelay--;
				}
			}
			else if global.SpindashEnabled or global.PeeloutEnabled
			{
				OverviewDelay = 120;
			}
	
			// Offset vertically
			if (ShiftUp or ShiftDown) and !OverviewDelay and !Player.DebugMode
			{
				if ShiftDown and OverviewOffset < 88 
				{
					OverviewOffset += 2;
				}
				if ShiftUp and OverviewOffset > -104 
				{
					OverviewOffset -= 2;
				} 	
			} 
			else if OverviewOffset != 0
			{
				OverviewOffset -= 2 * sign(OverviewOffset);
			}
		}
	}
	#endregion
	
	#region Position Update
	{
		// Calculate final view position
		if instance_exists(Stage)
		{
			ViewX = clamp(PosX + ExtendedOffset, Stage.LeftBoundary, Stage.RightBoundary  - global.Width);
			ViewY = clamp(PosY + OverviewOffset, Stage.TopBoundary,  Stage.BottomBoundary - global.Height);
		}
		else
		{
			ViewX = PosX;
			ViewY = PosY;
		}
		ViewX += ShakeX;
		ViewY += ShakeY;
	
		// Update camera position
		camera_set_view_pos(GameCamera, ViewX - global.ScreenBuffer, ViewY);
	}
	#endregion