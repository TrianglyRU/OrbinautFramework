function GameVariables()
{	
	// Global data
	Game.DevMode		= 0;
	Game.ActiveSave     = 0;
	Game.Character	    = 0;
	Game.Score		    = 0;
	Game.Lives		    = 0;
	Game.Continues	    = 0;
	Game.Emeralds	    = 0;
	Game.Time			= 0;
	Game.StageBoundary	= 0;
	Game.SpecialScore   = 0;
	Game.SpecialState   = 0;
	Game.StarpostID		= 0;
	Game.SpecialRingIDs	= [];
	Game.PlayerPosition	= [];
	Game.CurrentStage   = [];
	
	// Discord global data
	Game.DiscordEvent = "";
	Game.DiscordTime  = 0;

	// Graphics
	Game.WindowFullscreen = 0;
	Game.ResolutionWidth  = 0;
	Game.ResolutionHeight = 0;
	Game.WindowSize		  = 0;
	
	// Audio
	Game.MusicVolume = 0;
	Game.SoundVolume = 0;
	Game.LowTrack	 = [];
	Game.HighTrack	 = [];

	// Control
	Game.KeyboardControl = [];
	
	// Original differences
	Game.SpindashEnabled		= 0;
	Game.DropdashEnabled		= 0;
	Game.PeeloutEnabled			= 0;
	Game.GroundSpeedcap			= 0;
	Game.AirSpeedcap			= 0;	
	Game.RolljumpControl		= 0;		
	Game.ExtendedCamera			= 0;	
	Game.StrongerSlopeGravity	= 0;
	Game.LooseCrouch			= 0;
	Game.ConstantRollPhysics    = 0;
	Game.SpeedFloorClip			= 0;
	Game.ExtensiveWallCollision = 0;
	Game.BalancingCrouch		= 0;
	Game.BuffedWaterBarrier     = 0;
	Game.LimitVerticalSpeed		= 0;
	
	// Orbinaut improvements
	Game.PostProcessing      = 0;
	Game.SmoothRotation		 = 0;
	Game.RichPresenceSupport = 0;
	Game.PreciseRings	     = 0;
	Game.NoRollSpeedLimit	 = 0;
	Game.FlyingCancel	     = 0;
	Game.SuperCancel		 = 0;
}