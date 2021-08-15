function StartupScreenProcess()
{
	// Load into target room when timer runs out
	if !(--RoomTimer)
	{
		room_goto(DevMenu);
	}
}