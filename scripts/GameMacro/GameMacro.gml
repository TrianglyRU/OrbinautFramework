function _GameMacros()
{	
	/* Macros are basically replacement for using digits and numbers in your code to
	make it more practical. We could use emums in that case, but macros are easier */
	
	// Game macro
	#macro _init	     = 0
	#macro Game		     global	
	#macro FontDebug     0
	#macro FontDigits1   1
	#macro FontDigits2   2
	#macro FontCard      3
	#macro FontMenu      4
	#macro SavedChar     0
	#macro SavedZone     1
	#macro SavedEmeralds 2
	#macro SavedLives    3
	#macro SavedConts    4
	#macro SavedScore    5
	
	// Palette macro
	#macro Palette		     global
	#macro Uniform		     global
	#macro PaletteSurface    0
	#macro PaletteUnderwater 1
	#macro to		         0
	#macro from		         1
	#macro black	         0
	#macro white	         1
	#macro flash	         2
	
	// Player macro
	#macro PlayerStateNormal   0
	#macro PlayerStateRoll     1
	#macro PlayerStateAirborne 2
	#macro PlayerStateDebug    3
	#macro CharSonic		   0
	#macro CharTails	       1
	#macro CharKnuckles	       2
	#macro DirLeft	          -1
	#macro DirRight	           1
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
	#macro AnimClimbering	   19
	#macro AnimBalanceFront    20
	#macro AnimBalanceBack	   21
	#macro AnimSpring		   22
	#macro AnimActEnd		   23
	#macro AnimDropStand	   24

	// Stage macro
	#macro ActStateDefault     0
	#macro ActStateLoading	   1
	#macro ActStateFinished    2
	#macro ActStateBossfight   3
	#macro ActStateUnload      4
	#macro ActStateRestart     5
	
	// Collision macro
	#macro SideTop			   0
	#macro SideLeft			   1
	#macro SideRight		   2
	#macro SideBottom		   3
	#macro SideCentre		   4
	#macro SideCenter		   4	// >:(
	#macro CollisionHitbox     0
	#macro CollisionTriggerbox 1
	#macro RangeFloor	       0
	#macro RangeRWall	       1
	#macro RangeRoof		   2
	#macro RangeLWall		   3
	#macro TileSize            16
	#macro TileAmount          154
}