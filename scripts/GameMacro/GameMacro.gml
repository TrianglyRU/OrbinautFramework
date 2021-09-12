function GameMacro()
{	
	/* Macros are basically replacement for using digits in your code to
	make it more readable. We could use emums in that case, but macros are easier */
	
	// Global framework macro
	#macro Shader	   global
	#macro Game		   global
	#macro GameCamera  view_camera[0]

	// Object macro
	#macro EnemyBadnik 0
	#macro EnemyBoss   1
	#macro TypePause   1
	#macro TypeReset   2
	#macro TypeDelete  3
	#macro FlipLeft	  -1
	#macro FlipRight   1

	// Audio macro
	#macro PriorityLow  0
	#macro PriorityHigh 1
	#macro EventIdle	0
	#macro EventMute	1
	#macro EventUnmute  2
	#macro EventStop	3
	
	// Palette macro
	#macro PaletteLimit  64
	#macro PaletteDry    0
	#macro PaletteWet    1
	#macro FadeActive    0
	#macro FadeMax       1
	#macro FadeTo        0
	#macro FadeFrom      1
	#macro ColourBlack   0
	#macro ColorBlack    0
	#macro ColourWhite   1
	#macro ColorWhite    1
	#macro ColourFlash   2
	#macro ColorFlash    2
	#macro FlashWhite	 0
	#macro FlashNegative 1

	// Player macro
	#macro CharSonic		 0
	#macro CharTails	     1
	#macro CharKnuckles	     2
	#macro GlideFall         1
	#macro GlideAir          2
	#macro GlideGround       3
	#macro LayerA		     0
	#macro LayerB		     1
	#macro BarrierNormal	 1
	#macro BarrierThunder	 2
	#macro BarrierWater      3
	#macro BarrierFlame		 4	
	#macro AnimIdle		     0
	#macro AnimMove			 1
	#macro AnimPeelout	     2
	#macro AnimSpin			 3
	#macro AnimAirSpin		 4
	#macro AnimDropdash		 5
	#macro AnimSpindash		 6
	#macro AnimPush			 7
	#macro AnimCrouch		 8
	#macro AnimLookup		 9
	#macro AnimFly			 10
	#macro AnimFlyTired		 11
	#macro AnimSwim			 22
	#macro AnimSwimTired	 13
	#macro AnimHurt			 14
	#macro AnimDeath		 15
	#macro AnimDrown		 16
	#macro AnimGlide		 17
	#macro AnimGlideFall     18    
	#macro AnimSlide         19
	#macro AnimGetUp	     20
	#macro AnimClimb		 21
	#macro AnimClimbLedge	 22
	#macro AnimClimbFall     23
	#macro AnimSkid			 24
	#macro AnimBalance		 25
	#macro AnimBalanceFlip	 26
	#macro AnimSpring		 27
	#macro AnimActEnd		 28
	#macro AnimTransform	 29
	#macro AnimBreathe		 30
	
	// Collision macro
	#macro SideTop	  0
	#macro SideLeft	  1
	#macro SideRight  2
	#macro SideBottom 3
	#macro SideCentre 4
	#macro SideCenter 4
	#macro Hitbox	  0
	#macro Triggerbox 1
	#macro QuadFloor  0
	#macro QuadRWall  1
	#macro QuadRoof	  2
	#macro QuadLWall  3
}