function InputHotkeysRead()
{	
	if !Game.DevMode or !instance_exists(Stage) or Stage.State != ActStateDefault
	{
		exit;
	}
		
	// Stage fresh load (F1)
	if keyboard_check_pressed(vk_f1) 
	{
		Game.CheckpointID   = false;
		Game.PlayerPosition	= false;
		Game.Time		    = 0;
		Game.StageBoundary	= 0;
		Game.Score          = 0;
		Game.PalIndexDry[0] = 0;
		
		audio_stop_all();
		room_restart();
	}
	
	// Stage checkpoint restart (F2)
	if keyboard_check_pressed(vk_f2)
	{
		audio_stop_all();
		room_restart();
	}

	// Game restart (F3)
	if keyboard_check_pressed(vk_f3) 
	{
		game_restart();
	}

	// Low FPS mode (F4)
	if keyboard_check_pressed(vk_f4) 
	{
		if game_get_speed(gamespeed_fps) != 2
		{
			game_set_speed(2, gamespeed_fps);
		}
		else
		{
			game_set_speed(60, gamespeed_fps);
		}
	}
	
	// Update resolution (F5)
	if keyboard_check_pressed(vk_f5)
	{
		// Switch between
		if Game.ResolutionWidth == 320
		{
			Game.ResolutionWidth  = 400;
			Game.ResolutionHeight = 224;
		}
		else if Game.ResolutionWidth == 400
		{
			Game.ResolutionWidth  = 426;
			Game.ResolutionHeight = 240;
		}
		else if Game.ResolutionWidth == 426
		{
			Game.ResolutionWidth  = 320;
			Game.ResolutionHeight = 224;
		}
		Screen.Width  = Game.ResolutionWidth;
		Screen.Height = Game.ResolutionHeight;
		
		// Adjust room viewport to our resolution
		application_set_size(Game.ResolutionWidth, Game.ResolutionHeight);
		window_set_size(Game.ResolutionWidth * Game.WindowSize, Game.ResolutionHeight * Game.WindowSize);
	}
	
	// Give highspeed bonus (F6)
	if keyboard_check_pressed(vk_f6)
	{
		Player.HighSpeedBonus = 1200;
		audio_bgm_play(HighspeedMusic, -1, TypePriority);
	}
	
	// Give invincibility (F7)
	if keyboard_check_pressed(vk_f7)
	{
		Player.InvincibilityBonus = 1200;
		audio_bgm_play(InvincibilityMusic, -1, TypePriority);
	}
	
	// Give barrier (F8)
	if keyboard_check_pressed(vk_f8)
	{
		if !instance_exists(Barrier)
		{
			instance_create(floor(Player.PosX), floor(Player.PosY), Barrier);
			
			Player.BarrierType = BarrierNormal;	
			audio_sfx_play(sfxBarrier, false);			
		}
		else
		{
			switch Player.BarrierType
			{
				case BarrierNormal:
				{
					Player.BarrierType = BarrierFlame;
					audio_sfx_play(sfxFlameBarrier, false);
				}
				break;
				case BarrierFlame:
				{
					Player.BarrierType = BarrierThunder;
					audio_sfx_play(sfxThunderBarrier, false);
				}
				break;
				case BarrierThunder:
				{
					Player.BarrierType = BarrierWater;
					audio_sfx_play(sfxWaterBarrier, false);
				}
				break;
				case BarrierWater:
				{
					Player.BarrierType = BarrierNormal;
					audio_sfx_play(sfxBarrier, false);
				}
				break;
			}
		}	
	}
	
	// Grant extra life (F9)
	if keyboard_check_pressed(vk_f9)
	{
		Player.Lives++;
		audio_bgm_play(Jingle1UP, -1, TypeJingle);
	}
	
	// Hurt player (F10)
	if keyboard_check_pressed(vk_f10) 
	{
		object_damage(false, false, false);
	}
	
	// Switch Superform (F11)
	if keyboard_check_pressed(vk_f11) 
	{
		if !Player.SuperState
		{
			Player.SuperState = true;
			Player.Rings      = max(Player.Rings, 50);
		}
		else
		{
			Player.SuperState = false;
		}
	}
	
	// Perform random type of fade (F12)
	if keyboard_check_pressed(vk_f12)
	{
		var FadeMode   = choose(to, from);
		var FadeColour = choose(black, white, flash);
		
		fade_perform(FadeMode, FadeColour, 1);
	}
}