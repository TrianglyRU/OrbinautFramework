function GameVariables()
{
	// Dev mode
	Game.DevMode				 isVar;
	
	// Saving
	Game.ActiveSave				 isVar;
	Game.Saveslot			     isVar;
	
	// Global data to transfer between stages
	Game.GlobalCharacter		 isVar;
	Game.GlobalScore			 isVar;
	Game.GlobalLives			 isVar;
	Game.GlobalConts			 isVar;
	Game.GlobalEmeralds			 isVar;
	Game.GamePaused				 isVar;
	
	// Saved positions
	Game.SavedCheckpoint		 isVar;
	Game.SavedPosition			 isVar;
	Game.StageTransitionData     isArr;
	Game.StageTransitionData[10] = 0;
	
	Game.TransitionShiftPlayer[0]isVar;
	Game.TransitionShiftPlayer[1]isVar;
	Game.TransitionShiftCamera   isVar;
	
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
	
	// Gameplay
	Game.SpindashEnabled		 isVar;
	Game.DropdashEnabled		 isVar;
	Game.PeeloutEnabled			 isVar;
	Game.GroundSpeedcap			 isVar;
	Game.AirSpeedcap			 isVar;	
	Game.RolljumpControl		 isVar;		
	Game.ExtendedCamera			 isVar;	
	Game.OriginalRollLimit		 isVar;
	Game.FlyingCancel			 isVar;
	
	// Original differences
	Game.StrongerSlopeGravity	 isVar;
	Game.LooseCrouch			 isVar;
	Game.ConstantRollFrc		 isVar;
	Game.StrongerSlopeDetach	 isVar;
	Game.SpeedFloorClip			 isVar;
	Game.ExtensiveWallCollision  isVar;
	Game.BalancingCrouch		 isVar;
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
	
	// Palette
	Game.FadeEnabled			 isVar;
	Game.PaletteSet				 isVar;
	Game.PalIndexDry			 isArr;
	Game.PalIndexWet		     isArr;
	
	// Surfaces
	Game.CompleteSurf			 isVar;
	Game.MainSurf				 isVar;
	Game.BGSurf					 isVar;
}