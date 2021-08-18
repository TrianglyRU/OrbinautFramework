function PlayerTailsFlight()
{
	// Exit if we're not flying
	if !Player.FlightState
	{
		exit;
	}
	
	// Not tired
	if Player.FlightValue
	{
		// Affect vertical speed
		if Player.Ysp < -1
		{
			Player.Grv = 0.03125;
		}
		else if Input.ABCPress
		{
			Player.Grv = -0.125;
		}
		Player.Ysp = max(Player.Ysp, -4);
		
		// Play animation and sound
		if !Player.IsUnderwater
		{
			Player.Animation = AnimFly;
			audio_sfx_play(sfxFlying, true);
		}
		else
		{
			Player.Animation = AnimSwim;
			audio_sfx_stop(sfxFlying);
		}
		
		// Decrease timer
		Player.FlightValue--;
	}
	
	// Tired
	else
	{
		// Update gravity
		Player.Grv = 0.03125;
		
		// Play animation and sound
		if !Player.IsUnderwater
		{
			Player.Animation = AnimFlyTired;	
			audio_sfx_play(sfxTired, true);
		}
		else
		{
			Player.Animation = AnimSwimTired;
			audio_sfx_stop(sfxTired);
		}
		audio_sfx_stop(sfxFlying);
	}
	
	// Stop flying
	if Game.FlyingCancel and Input.Down and Input.ABCPress
	{
		Player.Spinning	   = true;
		Player.FlightState = false;
		Player.Grv		   = 0.21875;	
		Player.Animation   = AnimRoll;
		Player.RadiusX     = Player.SmallRadiusX;
		Player.RadiusY	   = Player.SmallRadiusY;
		Screen.RawY		  += Player.DefaultRadiusX - Player.SmallRadiusX;
		
		audio_sfx_stop(sfxFlying);	
		audio_sfx_stop(sfxTired);	
	}	
}