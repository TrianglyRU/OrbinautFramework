function GameMacro()
{	
	/* Macro are basically replacement for digits in your code to
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
	#macro PaletteType1    0
	#macro PaletteType2    1
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
	#macro AnimDropStand	 20
	#macro AnimGlideStand    21
	#macro AnimClimb		 22
	#macro AnimClimbLedge	 23
	#macro AnimClimbFall     24
	#macro AnimSkid			 25
	#macro AnimBalance		 26
	#macro AnimBalanceFlip	 27
	#macro AnimBalancePanic  28
	#macro AnimBalanceTurn   29
	#macro AnimSpring		 30
	#macro AnimActEnd		 31
	#macro AnimTransform	 32
	#macro AnimBreathe		 33
	
	// Collision macro
	#macro SideTop	  0
	#macro SideLeft	  1
	#macro SideRight  2
	#macro SideBottom 3
	#macro Hitbox	  0
	#macro Triggerbox 1
}