function PlayerTailsFlight()
{
	// Exit if we're not flying
	if !FlightState
	{
		exit;
	}
	
	// Check if we're still able to fly
	if FlightValue
	{
		// Affect vertical speed
		if Ysp < -1
		{
			Grv = 0.03125;
		}
		else if Input.ABCPress
		{
			Grv = -0.125;
		}
		Ysp = max(Ysp, -4);
		
		// Decrease timer
		FlightValue--;
		
		// Play animation and sound
		if !IsUnderwater
		{
			Animation = AnimFly;
			audio_sfx_play(sfxFlying, true);
		}
		else
		{
			Animation = AnimSwim;
			audio_sfx_stop(sfxFlying);
		}
	}
	
	// Check if Tails has tired
	else
	{
		// Update gravity
		Grv = 0.03125;
		
		// Play animation and sound
		if !IsUnderwater
		{
			Animation = AnimFlyTired;	
			audio_sfx_play(sfxTired, true);
		}
		else
		{
			Animation = AnimSwimTired;
			audio_sfx_stop(sfxTired);
		}
		audio_sfx_stop(sfxFlying);
	}
	
	// Check fly cancel is enabled, and we pressed A, B or C while holding DOWN
	if Game.FlyingCancel and Input.Down and Input.ABCPress
	{
		// Stop sounds
		audio_sfx_stop(sfxFlying);	
		audio_sfx_stop(sfxTired);	
		
		// Use smaller collision size
		RadiusX	= SmallRadiusX;
		RadiusY = SmallRadiusY;
		
		// Update character
		FlightState	= false;
		Spinning	= true;
		Grv			= 0.21875;	
		Animation	= AnimRoll;
		
		// Shift camera
		Screen.RawY += DefaultRadiusX - SmallRadiusX;
	}	
}