function GameSetup()
{
	// Game settings
	global.WindowTitle     = "Orbinaut Framework";
	global.StartRoom	   = Screen_DevMenu;
	global.DevMode         = true;
	global.ShowSplash      = false;
	global.Width           = 400;
	global.Height		   = 224;
	global.ScreenBuffer    = 8;
	global.KeyboardControl = [vk_up, vk_down, vk_left, vk_right, ord("Z"), ord("X"), ord("C"), vk_space, vk_enter];
	
	/* Default volume, screen size and fullscreen mode 
	are set in settings_load() script */
	
	// Originals differences. By defualt, the framework is in a mix of S2 and S3(K) state
	global.SpindashEnabled    = true;
	global.PeeloutEnabled	  = false;
	global.DropdashEnabled    = false;
	global.DSpinAttackEnabled = false;
	global.GroundSpeedcap	  = false;
	global.AirSpeedcap	      = false;
	global.RolljumpControl    = false;
	global.S2SpringBehaviour  = true;
	global.S2FloorCollision	  = true;
	global.S3SlopePhysics	  = false;
	global.S3WaterPhysics     = true;
	global.S3DeathRestart     = true;
	global.SKCrouch			  = false;
	global.SKRollDeceleration = true;
	global.SKWallCollision	  = true;
	global.SKItemBoxBehaviour = false;
	global.CDStageTimer	      = false;
	global.CDCamera			  = false;
	
	// Orbinaut improvements
	global.SmoothRotation	    = true;
	global.RichPresenceSupport  = true;
	global.BetterPlayerTileGrip = false;
	global.PreciseRingBehaviour = false;
	global.FixRollJump		    = false;
	global.FixDashRelease		= true;
	global.NoRollSpeedLimit	    = false;
	global.FlightCancel	        = false;
	
	// Initialise other variables
	global.Character	   = 0;
	global.ActiveSave      = 0;
	global.SaveData		   = 0;
	global.SaveState       = 0;
	global.FullscreenMode  = 0;
	global.WindowSize	   = 0;
	global.MusicVolume	   = 0;
	global.SoundVolume     = 0;
	global.Score		   = 0;
	global.Lives		   = 0;
	global.Continues	   = 0;
	global.Emeralds	       = 0;
	global.ZoneID		   = 0;
	global.StageRoom       = 0;
	global.SpecialScore    = 0;
	global.SpecialState    = 0;
	global.GameStartTime   = 0;	
	global.StarPostData    = [];
	global.BonusStageData  = [];
	global.SpecialRingData = [];
	global.SpecialRingList = [];
}