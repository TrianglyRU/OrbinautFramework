function PlayerCheckClimb()
{
	if CharacterID != CharKnuckles exit;
	
	if Climbing
	{
		Animation = AnimClimb;
		
		if Input.Up
		{
			Ysp = -1;
		}
		else if Input.Down
		{
			Ysp = 1;
		}
		else
		{
			Ysp = 0;
		}
		
		if Facing = FacingRight and !tile_meeting(floor(PosX + 11), floor(PosY), Layer)
		or Facing = FacingLeft and  !tile_meeting(floor(PosX - 11), floor(PosY), Layer)
		{
			Ysp		 = 0;
			Climbing = false;
		}
		if Input.ABCPress
		{
			Animation = AnimRoll;
			Ysp		 = -4;
			Xsp		 = 4 * Facing * -1;
			Climbing = false;
			Gliding  = false;
			Jumping  = true;
		}
	}
	
	if Gliding = 1 or Gliding = 2
	{
		if Xsp > 0 and tile_get_distance_h(floor(PosX + 11), floor(PosY), true, true, Layer) < 0
		or Xsp < 0 and tile_get_distance_h(floor(PosX - 11), floor(PosY), false, true, Layer) < 0
		{
			Gliding  = false;
			Climbing = true;
			Ysp		 = 0;
			Grv		 = 0.21875;
		}
	}
	
	
}