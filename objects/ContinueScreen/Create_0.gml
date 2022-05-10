/// @description Startup
// You can write your code in this editor
	
	RoomX          = global.Width  / 2;
	RoomY          = global.Height / 2;
	Countdown      = 659;
	State          = 0;
	RoomTimer	   = 0;
	CountFrame	   = 0;
	AnimationState = -1;
	
	// If we have no continues, force load into devmenu
	if !global.Continues
	{
		room_goto(Screen_DevMenu);
	}
	
	// Set character's sprite data
	switch global.Character
	{
		case CharSonic:
		{		
			CharSprite = [tex_obj_cont_sonic, spr_sonic_idle, spr_sonic_walk, spr_sonic_run];
			CharSpeed  = [10, 0];
		}
		break;
		case CharTails:
		{
			CharSprite = [tex_obj_cont_tails, spr_tails_idle, spr_tails_walk, spr_tails_run, spr_tails_dash];
			CharSpeed  = [24, 0];
		}
		break;
		case CharKnuckles:
		{
			CharSprite = [tex_obj_cont_knux, spr_knuckles_idle, spr_knuckles_walk, spr_knuckles_run];
			CharSpeed  = [[24, 12], 0];
		}
		break;
	}
	var SpriteData = [CharSprite[0], CharSpeed[0]];
	
	// Create character object and set an animation for them
	CharObject = instance_create(RoomX, RoomY + 45 + (global.Character == CharTails) * 4, ContinueCharacter);
	with CharObject
	{
		animation_play(SpriteData[0], SpriteData[1], 0);
	}
	
	// Create continue objects
	for (var i = 0; i < global.Continues; i++)
	{
		ContObject[i] = instance_create(RoomX + 21 * i - max(global.Continues - 1, 0) * 11, RoomY - 20, ContinueIcon);
	}
	
	fade_perform(ModeFrom, BlendBlack, 1);
	audio_bgm_play(AudioPrimary, Continue);