function PlayerDebugMode()
{
	// Exit if not in devmode or stage is paused
	if !Game.DevMode or Stage.IsPaused
	{
		return false;
	}
	
	if Input.BPress
	{
		// If player died, restore controls
		if Player.Death
		{
			Stage.AllowPause      = true;
			Stage.DoUpdate        = true;
			Screen.CameraEnabled  = true;
			Player.AllowCollision = true;
			Player.Death		  = false;
			Player.DrawOrder	  = layer_get_depth("Objects");
		}
		
		// Toggle debug
		Player.DebugMode = !Player.DebugMode;

		// If entered debug mdoe, reset flags. A lot of them
		if Player.DebugMode
		{			
			Player.AllowCollision = false;
			Player.Grounded	      = false;
			Player.OnObject	      = false;
			Player.MovementLock   = false;
			Player.NoControls	  = false;
			Player.FlightState    = false;
			Player.FlightValue    = false;
			Player.ClimbState	  = false;
			Player.ClimbValue	  = false;
			Player.GlideState	  = false;
			Player.GlideGrounded  = false;
			Player.GlideValue     = false;
			Player.Jumping		  = false;
			Player.Spinning	      = false;
			Player.RollJumping	  = false;
			Player.Skidding	      = false;
			Player.StickToConvex  = false;
			Player.IsUnderwater   = false;
			Player.AirTimer		  = 1800;
			Player.DebugSpeed     = 0;
			Player.Xsp			  = 0;
			Player.Ysp			  = 0;
			Player.Inertia		  = 0;
			Player.SpindashRev    = -1;
			Player.PeeloutRev     = -1;
			Player.DropdashRev    = -1;
			
			// Restore visibility
			Character.image_alpha = 1;
		}
		
		// If left debug mode, restore collision
		else
		{
			Player.Animation	  = AnimWalk;
			Player.RadiusX        = Player.DefaultRadiusX;
			Player.RadiusY		  = Player.DefaultRadiusY;
			Player.AllowCollision = true;
		}
	}
	
	// Exit the further code if not in debug mode
	if !Player.DebugMode
	{
		return false;
	}
	
	// Move player
	if Input.Left or Input.Down or Input.Right or Input.Up
	{
		if Input.Left
		{
			Player.PosX -= Player.DebugSpeed;
		}
		if Input.Right
		{
			Player.PosX += Player.DebugSpeed;
		}
		if Input.Up 
		{
			Player.PosY -= Player.DebugSpeed;
		}
		if Input.Down
		{
			Player.PosY += Player.DebugSpeed;
		}
		Player.DebugSpeed = min(Player.DebugSpeed + 0.046875, 16);
	}
	else
	{
		Player.DebugSpeed = 0;
	}
	
	// Update current object
	if Input.APress
	{
		Player.DebugItem++;
		Player.DebugItem = loop_value(Player.DebugItem, 0, array_length(Player.DebugList));
	}
	
	// Spawn current object
	if Input.CPress
	{
		instance_create(floor(Player.PosX), floor(Player.PosY), Player.DebugList[Player.DebugItem]);
	}
	
	// Return that we're in debug state
	return true;
}