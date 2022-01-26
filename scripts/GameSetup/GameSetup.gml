function GameSetup()
{
	// Game settings
	Game.WindowTitle     = "Orbinaut Framework";
	Game.StartRoom		 = Screen_DevMenu;	
	Game.DevMode         = true;
	Game.ShowSplash      = false;
	Game.Width           = 400;
	Game.Height			 = 224;
	Game.KeyboardControl = [vk_up, vk_down, vk_left, vk_right, ord("Z"), ord("X"), ord("C"), vk_space, vk_enter];
	
	// Originals differences
	Game.SpindashEnabled    = true;
	Game.PeeloutEnabled		= true;
	Game.DropdashEnabled    = false;
	Game.DSpinAttackEnabled	= false;
	Game.GroundSpeedcap	    = false;
	Game.AirSpeedcap	    = false;
	Game.RolljumpControl    = false;
	Game.S1FloorCollision	= true;
	Game.S3SlopePhysics		= false;
	Game.S3WaterPhysics		= false;
	Game.S3DeathRestart     = false;
	Game.SKCrouch			= false;
	Game.SKRollDeceleration	= true;
	Game.SKWallCollision	= false;	
	Game.SKItemBoxBehaviour = false;
	Game.CDStageTimer	    = true;	
	Game.CDCamera			= false;
	
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
	Game.FullscreenMode   = 0;
	Game.WindowSize	      = 0;
	Game.MusicVolume	  = 0;
	Game.SoundVolume      = 0;
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