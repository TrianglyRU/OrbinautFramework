function GameVariables()
{	
	// Dev mode
	Game.DevMode				 isVar;
	
	// Saving
	Game.ActiveSave				 isVar;
	Game.Saveslot			     isVar;
	
	// Global data to transfer between stages
	Game.Character		         isVar;
	Game.Score				     isVar;
	Game.Lives					 isVar;
	Game.Continues			     isVar;
	Game.Emeralds				 isVar;
	Game.CheckpointID		     isVar;
	Game.PlayerPosition		     isVar;
	Game.Time				     isVar;
	Game.StageBoundary			 isVar;
	Game.StageTransitionData     isArr;
	Game.StageTransitionData[10] = 0;
	
	// Graphics
	Game.WindowFullscreen		 isVar;
	Game.ResolutionWidth		 isVar;
	Game.ResolutionHeight		 isVar;
	Game.WindowSize				 isVar;
	
	// Audio
	Game.MusicVolume			 isVar;
	Game.SoundVolume			 isVar;
	
	Game.NormalTrack			 isArr;
	Game.PriorityTrack			 isArr;
	Game.JingleTrack			 isArr;
	Game.NormalTrack[5] = 0;
	Game.PriorityTrack[5] = 0;
	Game.JingleTrack[5] = 0;
	
	// Control
	Game.KeyboardControl		 isVar;
	
	// Original differences
	Game.SpindashEnabled		 isVar;
	Game.DropdashEnabled		 isVar;
	Game.PeeloutEnabled			 isVar;
	Game.GroundSpeedcap			 isVar;
	Game.AirSpeedcap			 isVar;	
	Game.RolljumpControl		 isVar;		
	Game.ExtendedCamera			 isVar;	
	Game.StrongerSlopeGravity	 isVar;
	Game.LooseCrouch			 isVar;
	Game.ConstantRollPhysics     isVar;
	Game.SpeedFloorClip			 isVar;
	Game.ExtensiveWallCollision  isVar;
	Game.BalancingCrouch		 isVar;
	Game.BuffedWaterBarrier      isVar;
	Game.StageTransitions		 isVar;
	
	// Orbinaut improvements
	Game.ImprovedObjCollision	 isVar;
	Game.ImprovedTileCollision   isVar;	
	Game.SmoothPaletteCycle		 isVar;
	Game.SmoothRotation			 isVar;
	Game.RichPresenceSupport	 isVar;
	Game.RingsPreciseCollision   isVar;
	Game.RingsNoBoundDespawn	 isVar;
	Game.RingsAllSideCollision   isVar;
	Game.NoRollSpeedLimit		 isVar;
	Game.FlyingCancel			 isVar;
}