function PlayerRollStart()
{
	if !ForcedRoll and (Input.Left or Input.Right) or SpindashRev != -1
	{
		return;
	}
	
	// Check if we should roll up
	var ManualRoll = false;
	if  Input.Down
	{
		if global.SKCrouch
		{
			if abs(Gsp) >= 1
			{
				ManualRoll = true;
			}
			else
			{
				Animation = AnimCrouch;
			}
		}
		else if abs(Gsp) >= 0.5
		{
			ManualRoll = true;
		}
	}
	
	// Roll up
	if ManualRoll or ForcedRoll
	{
		PosY     += DefaultRadiusY - SmallRadiusY;
		RadiusY   = SmallRadiusY;
		RadiusX	  = SmallRadiusX;
		Spinning  = true;
		Animation = AnimSpin;

		audio_sfx_play(sfxRoll, false);
	}
}