/// @description Game Startup / Setup
// You can write your code in this editor

	#region Macro
	{
		// Global framework macro
		#macro GlobalTime -1
		#macro Shader	   global
		#macro Font		   global
		#macro GameCamera  view_camera[0]
	
		// Object macro
		#macro FlagPause   1
		#macro FlagReset   2
		#macro FlagDelete  3
		#macro EnemyBadnik 0
		#macro EnemyBoss   1
		#macro FlipLeft	  -1
		#macro FlipRight   1

		// Audio macro
		#macro EventIdle       0
		#macro EventMute       1
		#macro EventUnmute     2
		#macro EventStop       3
		#macro AudioPrimary   -1
		#macro AudioSecondary -2
	
		// Palette macro. If you decide to change PalLimit, do the same with the value in ShaderMain.sfh
		#macro PalLimit	    64
		#macro PalPrimary	0
		#macro PalSecondary 1
	
		// Fade macro
		#macro StateActive 1
		#macro StateMax    2
		#macro ModeInto    0
		#macro ModeFrom    1
		#macro BlendBlack  0
		#macro BlendWhite  1
		#macro BlendFlash  2
	
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
		#macro ColHitbox  0
		#macro ColHitbox2 1
		#macro ColTrigger 2
		#macro ColSolidU  3
		#macro ColSolidD  4
		#macro ColSolidL  5
		#macro ColSolidR  6
		#macro ColSolidP  7
		#macro LayerA	  0
		#macro LayerB	  1
		#macro TileCount  255
	}
	#endregion
	
	// Setup Script
	GameSetup();

	#region Data Load
	{
		// Load config file and generate random seed
		settings_load();
		random_set_seed(randomise());
	
		// Load saved game data
		for (var i = 0; i < 4; i++)
		{
			global.SaveData[i] = savedata_load(i);
		}
	
		global.GameStartTime = date_current_datetime();
	}
	#endregion
	
	#region Window Startup
	{
		// Alert about incorrect global.Width
		if (global.Width / 2) mod 2 or (global.Height / 2) mod 2 != 0
		{
			show_message("UNSUPPORTED RESOLUTION! \nHalved width or height isn't an even value. You may experience some issues because of that");
		}
	
		// Update application and camera size to game resolution
		application_set_size(global.Width, global.Height);
	
		// Set window properties
		var Width  = global.Width  * global.WindowSize;
		var Height = global.Height * global.WindowSize;	
	
		window_set_position( (display_get_width() - Width) / 2, (display_get_height() - Height) / 2 );
		window_set_size(Width, Height);
	
		window_set_fullscreen(global.StartFullscreen);
		window_set_caption(global.WindowTitle);
	
		// ...and apply some GPU magic that will increase game speed!
		surface_depth_disable(true);
		gpu_set_alphatestenable(true);
		gpu_set_alphatestref(0);
	}
	#endregion
	
	#region Shaders Startup
	{
		// Setup fade module
		Shader.PalFadeValue  = shader_get_uniform(ShaderFade, "u_step");
		Shader.PalFadeMode   = shader_get_uniform(ShaderFade, "u_mode");
		Shader.PalFadeColour = shader_get_uniform(ShaderFade, "u_colour");
	
		// Setup palette module
		Shader.PalBoundary   = shader_get_uniform(ShaderMain,	    "u_bound");
		Shader.PalTexelSize1 = shader_get_uniform(ShaderMain,	    "u_texSizeFst");
		Shader.PalUVs1	     = shader_get_uniform(ShaderMain,	    "u_UVsFst");
		Shader.PalIndex1	 = shader_get_uniform(ShaderMain,	    "u_indFst");
		Shader.PalTex1		 = shader_get_sampler_index(ShaderMain, "u_texFst");
		Shader.PalTexelSize2 = shader_get_uniform(ShaderMain,	    "u_texSizeSnd");
		Shader.PalUVs2       = shader_get_uniform(ShaderMain,	    "u_UVsSnd");
		Shader.PalIndex2	 = shader_get_uniform(ShaderMain,	    "u_indSnd");
		Shader.PalTex2       = shader_get_sampler_index(ShaderMain, "u_texSnd");

		// Setup parallax module
		Shader.PrlActive    = shader_get_uniform(ShaderMain, "u_parallaxActive");
		Shader.PrlPos       = shader_get_uniform(ShaderMain, "u_pos");
		Shader.PrlWidth     = shader_get_uniform(ShaderMain, "u_width");
		Shader.PrlHeight    = shader_get_uniform(ShaderMain, "u_height");
		Shader.PrlScaleY    = shader_get_uniform(ShaderMain, "u_scaleY");
		Shader.PrlOffset	= shader_get_uniform(ShaderMain, "u_offset");
		Shader.PrlIncHeight = shader_get_uniform(ShaderMain, "u_ilHeight");
		Shader.PrlIncStep   = shader_get_uniform(ShaderMain, "u_ilStep");
		Shader.PrlMapSize   = shader_get_uniform(ShaderMain, "u_mapSize");
	}
	#endregion