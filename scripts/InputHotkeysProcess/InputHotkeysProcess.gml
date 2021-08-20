function InputHotkeysProcess()
{	
	if !Game.DevMode or !variable_check(Stage, "DoUpdate")
	{
		exit;
	}
		
	// Stage fresh load (F1)
	if keyboard_check_pressed(vk_f1) 
	{
		Game.StarpostID		= false;
		Game.PlayerPosition	= [];
		Game.Time		    = 0;
		Game.StageBoundary	= 0;
		Game.Score          = 0;
		
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
		if Game.Width == 320
		{
			Game.Width  = 400;
			Game.Height = 224;
		}
		else if Game.Width == 400
		{
			Game.Width  = 426;
			Game.Height = 240;
		}
		else if Game.Width == 426
		{
			Game.Width  = 320;
			Game.Height = 224;
		}
		Game.Width  = Game.Width;
		Game.Height = Game.Height;
		
		// Adjust room viewport to our resolution
		application_set_size(Game.Width, Game.Height);
		window_set_size(Game.Width * Game.WindowSize, Game.Height * Game.WindowSize);
	}
	
	// Give highspeed bonus (F6)
	if keyboard_check_pressed(vk_f6)
	{
		Player.HighspeedBonus = 1200;
		audio_bgm_play(PriorityLow, HighspeedMusic, noone);
	}
	
	// Give invincibility (F7)
	if keyboard_check_pressed(vk_f7)
	{
		Player.InvincibleBonus = 1200;
		audio_bgm_play(PriorityLow, InvincibilityMusic, noone);
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
		audio_bgm_play(PriorityHigh, ExtraLifeJingle, noone);
	}
	
	// Hurt player (F10)
	if keyboard_check_pressed(vk_f10) 
	{
		object_damage(false, false, false);
	}
	
	// Kill player (F11)
	if keyboard_check_pressed(vk_f11) 
	{
		object_damage(false, false, true);
	}
	
	// Add rings (F12 hold)
	if keyboard_check(vk_f12)
	{
		Player.Rings += 1;
	}
}