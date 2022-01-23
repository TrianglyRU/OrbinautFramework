function SplashScreenProcess()
{
	switch (++RoomTimer)
	{
		case 10:
			fade_perform(ModeFrom, BlendBlack, 1);
		break;
		case 150:
			fade_perform(ModeInto, BlendBlack, 1);
		break;
		case 180:
		{
			room_goto(Game.StartRoom);
		}
		break;
	}
}