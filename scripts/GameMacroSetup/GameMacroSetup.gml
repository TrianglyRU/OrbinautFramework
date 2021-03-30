function GameMacroSetup()
{		
	// Game macro
	#macro _init	   = 0
	#macro Game		   global
	#macro to		   0
	#macro from		   1
	#macro black	   0
	#macro white	   1
	#macro flash	   2
	#macro TileSize    16
	#macro TileAmount  154
	#macro FontDebug   0
	#macro FontDigits1 1
	#macro FontDigits2 2
	#macro FontCard    3
	#macro FontMenu    4
	
	#macro SavedChar     0
	#macro SavedZone     1
	#macro SavedEmeralds 2
	#macro SavedLives    3
	#macro SavedConts    4
	#macro SavedScore    5
	

	// Player macro
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
	
	#macro BarrierNormal	   0
	#macro BarrierElec		   1
	#macro BarrierWater        2
	#macro BarrierFire		   3
	
	#macro AnimIdle		       0
	#macro AnimWalk		       1
	#macro AnimRun		       2
	#macro AnimPeelout	       3
	#macro AnimRoll			   4
	#macro AnimPush			   5
	#macro AnimSpindash		   6
	#macro AnimCrouch		   7
	#macro AnimLookup		   8
	#macro AnimFly			   9
	#macro AnimFlyTired		   10
	#macro AnimHurt			   11
	#macro AnimDeath		   12
	#macro AnimGlide		   13
	#macro AnimClimb		   14
	#macro AnimGlideDrop	   15
	#macro AnimGlideSlide	   16
	#macro AnimSkid			   17
	#macro AnimGlideStand	   18
	
	// Stage macro
	#macro ActStateDefault     0
	#macro ActStateLoading	   1
	#macro ActStateFinished    2
	#macro ActStateBossfight   3
	#macro ActStatePlayerDeath 4
	#macro ActStateUnload      5
	
	// Object macro
	#macro SolidAll   0
	#macro SolidTop   1
	#macro SolidSlope 2
	#macro SolidNone  3
	
	#macro SideTop    0
	#macro SideLeft   1
	#macro SideRight  2
	#macro SideBottom 3
}