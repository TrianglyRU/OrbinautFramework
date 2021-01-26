function GameMacroInitialization()
{		
	// Game macro
	#macro Game      global
	#macro to    0
	#macro from  1
	#macro black 0
	#macro white 1
	#macro flash 2
	
	// Player macro
	#macro FloorL        0
	#macro FloorR        1
	#macro RoofL	     2
	#macro RoofR	     3
	#macro WallL		 4
	#macro WallR	     5
	#macro xPos			 0
	#macro yPos			 1
	#macro Ang		     2
	#macro Dist			 3
	#macro ModeFloor	 0
	#macro ModeWallR	 1
	#macro ModeRoof		 2
	#macro ModeWallL	 3
	#macro StateNormal   0
	#macro StateRolling  1
	#macro StateAirborne 2
	#macro CharSonic	 0
	#macro CharTails	 1
	#macro FacingLeft	-1
	#macro FacingRight	 1
	#macro LayerA		 0
	#macro LayerB		 1
	
	// Stage macro
	#macro StateDefault    0
	#macro StateFinished   1
	#macro StateBossfight  2
	#macro StateAfterboss  3
	
	// Object macro
	#macro SolidAll 0
	#macro SolidTop 1
	
}