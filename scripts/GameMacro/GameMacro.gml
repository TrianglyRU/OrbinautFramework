function GameMacro()
{	
	/* Macros are basically replacement for using digits and numbers in your code to
	make it more practical. We could use emums in that case, but macros are easier */
	
	// Main macro
	#macro Game	global

	// Object macro
	#macro RangeClose  1
	#macro RangeFar    7
	#macro EnemyBadnik 0
	#macro EnemyBoss   1
	
	// Variable macro
	#macro isVar		 = 0
	#macro isArr		[0] = 0	
	#macro isAsset		= 0
	#macro isReal		= 0
	#macro isBool		= false
	#macro isArray		[99] = 0
	#macro isString		= ""
	
	// Game macro
	#macro FontDebug     0
	#macro FontDigits1   1
	#macro FontDigits2   2
	#macro FontCard      3
	#macro FontMenu      4
	
	// Savedata macro
	#macro SavedChar     0
	#macro SavedZone     1
	#macro SavedEmeralds 2
	#macro SavedLives    3
	#macro SavedConts    4
	#macro SavedScore    5
	
	// Audio macro
	#macro TypeNormal	   0
	#macro TypePriority    1
	#macro TypeJingle	   2
	#macro TypeAll		   3
	#macro TrackIndex	   0
	#macro TrackID		   1
	#macro TrackLoop	   2
	#macro TrackEvent	   3
	#macro TrackEventTime  4	
	#macro EventIdle	   0
	#macro EventMute	   1
	#macro EventUnmute     2
	#macro EventStop	   3
	
	// Shader macro
	#macro Shader global
	
	// Palette macro
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
	#macro GlidingAir		   1
	#macro GlidingDrop	       2
	#macro GlidingGround	   3
	#macro GlidingStop		   4
	#macro GlidingTurn		   5
	#macro GlidingDropStand    6
	#macro SuperStart		   1
	#macro SuperActive		   2
	#macro SuperEnd			   3
	#macro DirectionLeft	  -1
	#macro DirectionRight	   1
	#macro LayerA		       0
	#macro LayerB		       1
	#macro BarrierNormal	   1
	#macro BarrierThunder	   2
	#macro BarrierWater        3
	#macro BarrierFlame		   4
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
	#macro AnimSwim			   25
	#macro AnimSwimTired	   26
	#macro AnimTransform	   27
	#macro AnimDrown		   28

	// Stage macro	
	#macro ActStateLoading	   0
	#macro ActStateDefault     1
	#macro ActStateFinished    2	
	#macro ActStateUnload      3
	
	// Collision macro
	#macro SideTop			   0
	#macro SideLeft			   1
	#macro SideRight		   2
	#macro SideBottom		   3
	#macro SideCentre		   4
	#macro SideCenter		   4
	#macro CollisionHitbox     0
	#macro CollisionTriggerbox 1
	#macro RangeFloor	       0
	#macro RangeRWall	       1
	#macro RangeRoof		   2
	#macro RangeLWall		   3
	#macro TileSize            16
	#macro TileAmount          147
}