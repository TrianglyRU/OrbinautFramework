function GameSetup()
{
	/* If set to false the game will load into the DevMenu, else into the room
	set in the ScreenStartupProcess() script. This won't work if Game.ShowSplash is enabled */
	Game.ForceLoad = false;	
	
	/* Video, audio and control settings are overwritten by 
	game settings if Developer Mode is disabled! */
	
	// Game settings
	Game.WindowTitle     = "Orbinaut Framework";
	Game.DevMode         = true;
	Game.ShowSplash      = true;
	Game.FullscreenMode  = false;
	Game.Width           = 400;
	Game.Height			 = 224;
	Game.WindowSize	     = 3;
	Game.MusicVolume	 = 0.5;
	Game.SoundVolume     = 0.5;
	Game.KeyboardControl = [vk_up, vk_down, vk_left, vk_right, ord("Z"), ord("X"), ord("C"), vk_space, vk_enter];
	
	// Originals differences
	Game.SpindashEnabled    = true;
	Game.PeeloutEnabled		= true;
	Game.DropdashEnabled    = false;
	Game.DSpinAttackEnabled	= false;
	Game.GroundSpeedcap	    = false;
	Game.AirSpeedcap	    = false;
	Game.CDCamera			= false;
	Game.RolljumpControl    = false;
	Game.S3SlopePhysics		= false;
	Game.S3WaterPhysics		= false;
	Game.SKCrouch			= false;
	Game.SKRollDeceleration	= false;
	Game.S1FloorCollision	= false;
	Game.SKWallCollision	= false;	
	Game.SKItemBoxBehaviour = false;
	Game.CDStageTimer	    = false;	
	
	// Orbinaut improvements
	Game.SmoothRotation	      = true;
	Game.RichPresenceSupport  = true;
	Game.BetterPlayerTileGrip = false;
	Game.PreciseRingBehaviour = false;
	Game.NoRollSpeedLimit	  = true;
	Game.FlightCancel	      = false;
	
	// Initialise other variables
	Game.Character		  = 0;
	Game.ActiveSave       = 0;
	Game.SaveData		  = 0;
	Game.SaveState        = 0;
	Game.Score		      = 0;
	Game.Lives		      = 0;
	Game.Continues	      = 0;
	Game.Emeralds	      = 0;
	Game.Stage			  = 0;
	Game.StageRoom        = 0;
	Game.SpecialScore     = 0;
	Game.SpecialState     = 0;
	Game.AnimationTime	  = 0;
	Game.UpdateAnimations = 0;
	Game.DiscordTime	  = 0;	
	Game.DiscordEvent	  = "";
	Game.StarPostData     = [];
	Game.BonusStageData   = [];
	Game.SpecialRingData  = [];
	Game.SpecialRingList  = [];
}