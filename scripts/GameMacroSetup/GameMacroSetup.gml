function GameMacroSetup()
{		
	// Game macros
	#macro Script	function
	#macro Game		global
	#macro to		0
	#macro from		1
	#macro black	0
	#macro white	1
	#macro flash	2
	#macro TileSize 16

	// Player macros
	#macro RangeFloor	       0
	#macro RangeRWall	       1
	#macro RangeRoof		   2
	#macro RangeLWall		   3	
	#macro PlayerStateNormal   0
	#macro PlayerStateRoll     1
	#macro PlayerStateAirborne 2
	#macro CharSonic		   0
	#macro CharTails	       1
	#macro CharKnuckles	       2	
	#macro FacingLeft	      -1
	#macro FacingRight	       1
	#macro LayerA		       0
	#macro LayerB		       1
	#macro AnimIdle		       0
	#macro AnimWalk		       1
	#macro AnimRun		       2
	#macro AnimPeelout	       3
	#macro AnimRoll			   4
	#macro AnimPush			   5
	#macro AnimSpindash		   6
	#macro AnimCrouch		   7
	#macro AnimLookup		   8
	
	// Stage macros
	#macro ActStateDefault   0
	#macro ActStateFinished  1
	#macro ActStateBossfight 2
	#macro ActStateAfterboss 3
	
	// Object macros
	#macro SolidAll 0
	#macro SolidTop 1	
}