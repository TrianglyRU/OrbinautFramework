function ContinueScreenStartup()
{
	// Initialise variables
	RoomX      = Game.Width  / 2;
	RoomY      = Game.Height / 2;
	Countdown  = 659;
	State      = 0;
	RoomTimer  = 0;
	CountFrame = 0;
	
	// Set character's sprite data
	switch Game.Character
	{
		case CharSonic:
		{		
			CharSprite = [tex_obj_cont_sonic_wait, tex_obj_cont_sonic_action];
			CharSpeed  = [18, 0];
		}
		break;
		case CharTails:
		{
			CharSprite = [tex_obj_cont_tails_wait, tex_obj_cont_tails_action];
			CharSpeed  = [24, 0];
		}
		break;
		case CharKnuckles:
		{
			CharSprite = [tex_obj_cont_knux_wait, tex_obj_cont_knux_action];
			CharSpeed  = [12, 0];
		}
		break;
	}
	var StartData = [CharSprite[0], CharSpeed[0]];

	// Create character object and set an animation for them
	CharObject = instance_create(RoomX, RoomY + 52, ContinueCharacter);
	with CharObject
	{
		animation_play(StartData[0], StartData[1], 0);
	}
	
	// Create continue objects
	for (var i = 0; i < Game.Continues; i++)
	{
		ContObject[i] = instance_create(RoomX + 21 * i - max(Game.Continues - 1, 0) * 11, RoomY - 20, ContinueIcon);
	}
	
	// Perform fade
	fade_perform(ModeFrom, BlendBlack, 1);
	
	// Play music
	audio_bgm_play(ChannelPrimary, Continue);
}