/// @function object_act_solid_backup(collideSides, collideTop, collideBottom, collisionMap)
function object_act_solid_backup(collideSides, collideTop, collideBottom, collisionMap)
{
	// Exit the code if collisions are disabled
	if !Player.AllowCollision
	{
		exit;
	}
	
	// Exit the code if no solid radiuses were initialized for this object
	if !variable_instance_exists(id, "objXRadiusSolid")
	{
		exit;
	}
	
	// Exit the code if object can't be collided
	if !objXRadiusSolid or !objYRadiusSolid
	{
		return false;	
	}
	
	// Exit the code if there is no side to collide with 
	if !collideSides and !collideTop and !collideBottom
	{
		exit;
	}
	
	// Get object properties
	var objectX		   = floor(x);
	var objectY        = floor(y);
	var objectTop      = floor(y - objYRadiusSolid - 0);
	var objectLeft     = floor(x - objXRadiusSolid - 0);
	var objectRight    = floor(x + objXRadiusSolid - 1);
	var objectBottom   = floor(y + objYRadiusSolid - 0);	
	var objectMirrored = !image_xscale;
	var objectFlipped  = !image_yscale;
	var objectID	   = id;

	// Get player properties
	var playerX      = floor(Player.PosX);
	var playerY      = floor(Player.PosY);
	var playerTop    = floor(Player.PosY - Player.RadiusY);
	var playerLeft   = floor(Player.PosX - 11);
	var playerRight  = floor(Player.PosX + 11);
	var playerBottom = floor(Player.PosY + Player.RadiusY);
	
	// Check if player is standing on this object, collide only with its top side
	if object_player_stand(objectID)
	{	
		// Check if collision map array is assigned and object is not flipped
		if collisionMap != false and !objectFlipped
		{
			// Get player position within the object
			var playerPosition = objectMirrored ? objectRight - playerX : playerX - objectLeft;

			// Define new object top position based on current player position
			if playerPosition < 0
			{
				objectTop = objectY - collisionMap[0];
			}
			else if playerPosition >= objXRadiusSolid * 2
			{
				objectTop = objectY - collisionMap[objXRadiusSolid * 2 - 1];
			}
			else
			{
				objectTop = objectY - collisionMap[playerPosition];
			}
		}

		// Check if player is outside of this object collision diameter
		if playerX + collideSides * 10 < objectLeft or playerX - collideSides * 10 > objectRight or !collideTop
		{
			Player.OnObject = false;
			exit;
		}
		
		// Make player to follow horizonatal movement of the object
		Player.PosX += floor(x - xprevious);
							
		// Make player to always stay on top of the object
		Player.PosY += objectTop - playerBottom - 1;
	}
			
	// If player is not standing on this object, collide with it
	else
	{
		// Check for overlap with this object horizontally
		if playerRight < objectLeft or playerLeft > objectRight
		{
			exit;
		}
		
		// Check if collision map array is assigned and object is not flipped
		if collisionMap != false and !objectFlipped
		{
			// Get player position within the object
			var playerPosition = objectMirrored ? objectRight - playerX : playerX - objectLeft;

			// Define new object top position based on current player position
			if playerPosition < 0
			{
				objectTop = objectY - collisionMap[0];
			}
			else if playerPosition >= objXRadiusSolid * 2
			{
				objectTop = objectY - collisionMap[objXRadiusSolid * 2 - 1];
			}
			else
			{
				objectTop = objectY - collisionMap[playerPosition];
			}
		}
			
		// Check for overlap with this object vertically
		if playerBottom < objectTop - !collideSides * 4 or playerTop > objectBottom
		{
			/* Originals shifted solidbox by 4 pixels upwards on every single object. Instead
			we'll shift only top bound of platform objects (that can't be collided horizontally) */
			
			// Exit the code if no overlap occured
			exit;
		}
					
		// Collide with this object vertically
		if abs(objectX - playerX) <= abs(objectY - playerY) or !collideSides
		{
			// Check if bottom side is solid
			if collideBottom
			{
				// Check if player is below this object
				if playerY > objectY and playerTop < objectBottom
				{
					// If player is grounded, kill them
					if Player.Grounded
					{
						object_damage(false, false, false, true);
					}

					// Else push player out from this object
					else if Player.Ysp < 0
					{
						if Player.FlightState
						{
							Player.Grv = 0.03125;
						}			
						Player.PosY += objectBottom - playerTop;
						Player.Ysp   = 0;
					}	
				}
			}

			// Check if top side is solid
			if collideTop 
			{	
				// Check if player is above this object and not 16 pixels into it
				if playerBottom < objectTop + 16
				{
					// Check if player sides are within this object boundaries
					if playerX < objectLeft - collideSides * 10 or playerX > objectRight + collideSides * 10
					{
						/* Originals check for player's x position on every object instead, which caused some problems. 
						Instead we'll use the same logic as in 'walking off object' code */	
						
						// Exit the code if no overlap occured
						exit;
					}
						
					with Player
					{
						// Check if player is moving downwards or standing still
						if Ysp < 0
						{
							exit;
						}
							
						// Check for landing with water barrier
						if BarrierType == BarrierWater and BarrierIsActive
						{
							// Set flags and speed
							BarrierIsActive = false;
							Jumping			= true;
							Ysp				= -7.5;
							
							// Play sound
							audio_sfx_play(sfxWaterBarrierBounce, false);
								
							// Exit the further code
							exit;
						}
						
						// Keep rolling if DOWN button is held (and we're not in climb state)
						if Ysp > 0 and !Grounded and !ClimbState
						{
							if Input.Down and !Input.Left and !Input.Right
							{
								Rolling = true;
								audio_sfx_play(sfxRoll, false);
							}
							else
							{
								Rolling = false;
							}
						}
						
						// Reset flags
						Jumping			= false;
						Pushing			= false;
						GlideState      = false;
						GlideGrounded   = false;
						GlideValue      = false;
						ClimbState	    = false;
						FlightState     = false;
						FlightValue		= false;
						ScoreCombo		= false;
						BarrierIsActive = false;
						
						audio_sfx_stop(sfxFlying);
						audio_sfx_stop(sfxTired);
						
						// Become grounded
						Grounded = true;
						OnObject = objectID;
						
						// Reset gravity
						if !IsUnderwater
						{
							Grv	= 0.21875;
						}
						else
						{
							// Lower by 0x28 (0.15625) if underwater
							Grv = 0.0625
						}
						
						// Reset visual angle
						VisualAngle = 360;
		
						// Reset hurt state
						if Hurt
						{
							Hurt		 = false;
							IsInvincible = 121;	
							Xsp			 = 0;
						}
							
						// Set speeds and angle
						Inertia = Xsp;		
						Ysp     = 0;
						Angle   = 360;
		
						// Perform Dropdash (if charged), else reset
						if DropdashRev == 20
						{	
							// Go to rolling state
							Rolling = true;
		
							// Set dropspeed
							if DropdashDirection == DirectionRight
							{
								var Dropspeed = Inertia / 4 + 8 * Facing;
							}
							else if DropdashDirection = DirectionLeft
							{
								if Angle == 360
								{
									var Dropspeed = 8 * Facing;
								}
								else
								{
									var Dropspeed = Inertia / 2 + 8 * Facing;
								}
							}
							Dropspeed = clamp(Dropspeed, -12, 12);
			
							// Apply dropspeed to inertia and set camera lag
							Inertia			   = Dropspeed;
							DropdashRev		   = -1;
							Screen.ScrollDelay = 16;
			
							// Set 'roll' animation
							Animation = AnimRoll;
						}
						else
						{
							DropdashRev = -1;
						}
						
						// Reset radiuses to default values
						if !Rolling
						{
							PosY   -= DefaultRadiusY - RadiusY;
							RadiusY = DefaultRadiusY; 
							RadiusX	= DefaultRadiusX;
						}
								
						// Attach player to the object's top boundary
						PosY += objectTop - playerBottom - 1;
					}
				}	
			}
		}
			
		// Collide with this object horizontally
		else
		{
			if collideSides
			{
				with Player
				{
					// Collide on the right
					if playerX > objectX
					{
						if Xsp < 0
						{
							if Grounded
							{
								Inertia = 0;
							}
							Xsp = 0;
						}
						PosX += objectRight - playerLeft;
					}
						
					// Collide on the left
					else if playerX < objectX
					{	
						if Xsp > 0
						{
							if Grounded
							{
								Inertia = 0;
							}
							Xsp = 0;
						}
						PosX += objectLeft - playerRight;
					}
				}
			}
		}
	}
}