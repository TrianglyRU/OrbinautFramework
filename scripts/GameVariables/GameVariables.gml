function GameVariables()
{	
	// Global data
	Game.DevMode		 = 0;
	Game.ShowSplash	     = 0;
	Game.ActiveSave      = 0;
	Game.SaveState       = 0;
	Game.Character	     = 0;
	Game.Score		     = 0;
	Game.Lives		     = 0;
	Game.Continues	     = 0;
	Game.Emeralds	     = 0;
	Game.Time			 = 0;
	Game.Rings			 = 0;
	Game.Stage			 = 0;
	Game.StageBoundary	 = 0;
	Game.StageRoom       = 0;
	Game.SpecialScore    = 0;
	Game.SpecialState    = 0;
	Game.StarPostData    = [];
	Game.SpecialRingData = [];
	Game.SpecialRingList = [];
	
	// Collision
	Game.TileLayers  = [];
	Game.TileData	 = [];
	Game.TileAngle	 = [];
	Game.TileHeights = [];
	Game.TileWidths  = [];
	
	// Discord global data
	Game.DiscordEvent = "";
	Game.DiscordTime  = 0;

	// Graphics
	Game.WindowFullscreen = 0;
	Game.Width			  = 0;
	Game.Height			  = 0;
	Game.WindowSize		  = 0;
	Game.AnimationTime	  = 0;
	
	// Audio
	Game.MusicVolume = 0;
	Game.SoundVolume = 0;

	// Control
	Game.KeyboardControl = [];
	
	// Originals differences
	Game.SpindashEnabled    = 0; 
	Game.DropdashEnabled    = 0;
	Game.PeeloutEnabled		= 0; 
	Game.GroundSpeedcap	    = 0; 
	Game.AirSpeedcap	    = 0;
	Game.CDCamera			= 0;
	Game.RolljumpControl    = 0;
	Game.S3SlopePhysics		= 0;
	Game.SKCrouch			= 0;
	Game.SKRollDeceleration = 0;
	Game.S2FloorCollision	= 0;
	Game.SKWallCollision	= 0;
	Game.SMWaterBarrier		= 0;
	Game.SMRingBehaviour	= 0;
	Game.SKItemBoxBehaviour = 0;
	Game.CDStageTimer		= 0;
	
	// Orbinaut improvements
	Game.CustomSlopeCollision = 0;
	Game.SmoothRotation	      = 0;
	Game.RichPresenceSupport  = 0;
	Game.NoRollSpeedLimit	  = 0;
	Game.FlightCancel	      = 0;
}