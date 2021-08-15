function StartupScreenProcess()
{
	// Countdown room timer
	RoomTimer--;
	
	// Load into target room when timer runs out
	if !RoomTimer
	{
		room_goto(MQZ0);
	}
}