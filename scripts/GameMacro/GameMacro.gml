function GameMacro()
{	
	// Global framework macro
	#macro Shader	   global
	#macro Game		   global
	#macro GameCamera  view_camera[0]

	// Object macro
	#macro TypeBadnik  0
	#macro TypeBoss    1
	#macro TypePause   1
	#macro TypeReset   2
	#macro TypeDelete  3
	#macro FlipLeft	  -1
	#macro FlipRight   1

	// Audio macro
	#macro ChannelPrimary   -2
	#macro ChannelSecondary -1
	#macro EventIdle	     0
	#macro EventMute	     1
	#macro EventUnmute       2
	#macro EventStop	     3
	
	// Palette macro
	#macro PaletteLimit  64
	#macro TypePrimary   0
	#macro TypeSecondary 1
	
	// Fade macro
	#macro StateActive   0
	#macro StateMax      1
	#macro ModeInto      0
	#macro ModeFrom      1
	#macro BlendBlack    0
	#macro BlendWhite    1
	#macro BlendFlash    2
	
	// Player macro
	#macro CharSonic		0
	#macro CharTails	    1
	#macro CharKnuckles	    2
	#macro ClimbJump	   -1
	#macro ClimbWall        1
	#macro ClimbLedge		2
	#macro GlideFall        1
	#macro GlideAir         2
	#macro GlideGround      3
	#macro DashLocked      -1
	#macro DashReady        0
	#macro DashActive	    1
	#macro DashRecharge     2
	#macro SpinRecharge    -2
	#macro SpinReady	   -1
	#macro SpinActive       0
	#macro BarrierNormal	1
	#macro BarrierThunder	2
	#macro BarrierWater     3
	#macro BarrierFlame		4	
	#macro AnimIdle		    0
	#macro AnimMove			1
	#macro AnimPeelout	    2
	#macro AnimSpin			3
	#macro AnimDropdash		4
	#macro AnimSpindash		5
	#macro AnimPush			6
	#macro AnimCrouch		7
	#macro AnimLookup		8
	#macro AnimFly			9
	#macro AnimFlyTired		10
	#macro AnimSwim			11
	#macro AnimSwimTired	12
	#macro AnimHurt			13
	#macro AnimDeath		14
	#macro AnimDrown		15
	#macro AnimGlide		16
	#macro AnimGlideFall    17    
	#macro AnimSlide        18
	#macro AnimDropStand	19
	#macro AnimGlideStand   20
	#macro AnimClimb		21
	#macro AnimClamber	    22
	#macro AnimDrop         23
	#macro AnimSkid			24
	#macro AnimBalance		25
	#macro AnimBalanceFlip	26
	#macro AnimBalancePanic 27
	#macro AnimBalanceTurn  28
	#macro AnimSpring		29
	#macro AnimTransform	30
	#macro AnimBreathe		31
	
	// Collision macro
	#macro SideTop	    0
	#macro SideLeft	    1
	#macro SideRight    2
	#macro SideBottom   3
	#macro TypeHitbox   0
	#macro TypeHitbox2  1
	#macro TypeSolidbox 2
	#macro TypeTrigger  3
	#macro LayerA	    0
	#macro LayerB	    1
}