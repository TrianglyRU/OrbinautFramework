/// @function object_act_solid(collideSides, collideTop, collideBottom, collisionMap)
function object_act_solid(collideSides, collideTop, collideBottom, collisionMap)
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
	
	// Exit the code if there is no side to collide with 
	if !collideSides and !collideTop and !collideBottom
	{
		exit;
	}
	
	// Get object properties
	var objectX		   = floor(x);
	var objectY        = floor(y);
	var objectTop      = floor(y - objYRadiusSolid);
	var objectLeft     = floor(x - objXRadiusSolid);
	var objectRight    = floor(x + objXRadiusSolid);
	var objectBottom   = floor(y + objYRadiusSolid);	
	var objectMirrored = !image_xscale;
	var objectFlipped  = !image_yscale;
	var objectID	   = id;

	// Get player properties
	var playerX      = floor(Player.PosX);
	var playerY      = floor(Player.PosY);
	var playerTop    = floor(Player.PosY - Player.yRadius);
	var playerLeft   = floor(Player.PosX - 11);
	var playerRight  = floor(Player.PosX + 11);
	var playerBottom = floor(Player.PosY + Player.yRadius);
	
	// Adjust solidbox
	if !Game.ImprovedObjCollision
	{
		objectBottom += 1;
	}	
	else
	{
		objectRight -= 1;
	}
	
	// Check if player is standing on this object, and collide only with its top side
	if object_player_stand(id)
	{	
		// Check if collision map array is assigned and object is not flipped
		if collisionMap != false and !objectFlipped
		{
			// Get player position within the object
			var playerPosition = objectMirrored ? objectRight - playerX : playerX - objectLeft;

			// Define new object top position based on current player position
			if playerPosition < 0
			{
				objectTop = objectY - collisionMap[0] - 1;
			}
			else if playerPosition > objXRadiusSolid * 2
			{
				objectTop = objectY - collisionMap[objXRadiusSolid * 2] - 1;
			}
			else
			{
				objectTop = objectY - collisionMap[playerPosition] - 1;
			}
		}
		
		// Check if player is outside of this object collision diameter
		var edgeExtension = (collideSides or Game.ImprovedObjCollision) * 10	
		if  playerX + edgeExtension < objectLeft or playerX - edgeExtension > objectRight or !collideTop
		{
			Player.OnObject = false;
			exit;
		}
		
		// Make player to follow horizonatal movement of the object
		Player.PosX += floor(x - xprevious);
							
		// Make player to always stay on top of the object
		Player.PosY += objectTop - playerBottom - 1;
		
		// Check if player should start balancing
		var edgeExtension = (!collideSides and !Game.ImprovedObjCollision) * 5
		
		if Player.Inertia == 0
		{
			if floor(Player.PosX) < objectLeft  + edgeExtension and Player.Facing == DirLeft
			or floor(Player.PosX) > objectRight - edgeExtension and Player.Facing == DirRight
			{
				Player.Balancing = DirRight;
			}
			if floor(Player.PosX) < objectLeft  + edgeExtension and Player.Facing == DirRight
			or floor(Player.PosX) > objectRight - edgeExtension and Player.Facing == DirLeft
			{
				Player.Balancing = DirLeft;
			}
		}
	}
			
	// If player is not standing on this object, collide with it
	else
	{
		// Check for overlap with this object horizontally
		if playerRight < objectLeft or playerLeft > objectRight
		{
			exit;
		}
		
		// If collisionMap is assigned, define new top or bottom boundary
		if collisionMap != false
		{
			// Get player position within the object
			var playerPosition = objectMirrored ? objectRight - playerX : playerX - objectLeft;
				
			// Define new object actual height based on current player position
			if playerPosition < 0
			{
				objYRadiusSolid = collisionMap[0];
			}
			else if playerPosition > objXRadiusSolid * 2
			{
				objYRadiusSolid = collisionMap[objXRadiusSolid * 2];
			}
			else
			{
				objYRadiusSolid = collisionMap[playerPosition];
			}
				
			// Set new object bottom boundary
			if objectFlipped
			{
				objectBottom = objectY + objYRadiusSolid;
			}
				
			// Set new object top boundary
			else
			{
				objectTop = objectY - objYRadiusSolid;
			}
		}
			
		// Check for overlap with this object vertically
		if  playerBottom < objectTop - !(Game.ImprovedObjCollision and collideSides) * 4 or playerTop > objectBottom - !Game.ImprovedObjCollision * 4
		{
			exit;
		}
					
		// Collide with this object vertically		
		if abs(objectX - playerX) + 4 <= abs(objectY - playerY) - 4 or !collideSides
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
						if (Player.FlyingState) Player.Grv = 0.03125;
							
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
					// Check if player's position is within this object boundaries
					if !collideSides and (playerX < objectLeft or playerX > objectRight)
					{
						exit;
					}
					if !Game.ImprovedObjCollision and (playerX < objectLeft or playerX > objectRight)
					{
						exit;
					}
					if Game.ImprovedObjCollision and (playerRight <= objectLeft or playerLeft >= objectRight)
					{
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
							Jumping			= false;
							Ysp				= -7.5;
							
							// Play sound
							audio_sfx_play(sfxWaterBarrierBounce, false, true);
								
							// Exit the further code
							exit;
						}
							
						// Reset gravity
						Grv	= 0.21875;
		
						// Reset flags
						Rolling			= Ysp > 0 and !Grounded ? Input.Down : Rolling;
						BarrierIsActive = false;
						Jumping			= false;
						Pushing			= false;
						Grounded		= true;
						OnObject		= objectID;
							
						// Set visual angle
						VisualAngle = 360;
		
						// Reset hurt state
						if Hurt
						{
							isInvincible = 120;
							Xsp			 = 0;
							Hurt		 = false;			
						}
							
						// Set speed and angle
						Inertia  = Xsp;
						Angle    = 360;		
						Ysp      = 0;
		
						// Sonic's dropdash
						if DropdashRev == 20
						{	
							// Go to rolling state
							Rolling = true;
								
							// Set dropspeed
							if DropdashDirection == DirRight
							{
								var Dropspeed = Inertia / 4 + 8 * Facing;
							}
							else if DropdashDirection = DirLeft
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
							if (Dropspeed >  12) Dropspeed =  12;
							if (Dropspeed < -12) Dropspeed = -12;
		
							// Apply dropspeed to inertia and set camera lag
							Inertia			   = Dropspeed;
							DropdashRev		   = -2;
							Screen.ScrollDelay = 16;
			
							// Set 'roll' animation
							Animation = AnimRoll;
						}
						else
						{
							DropdashRev = -1;
						}
		
						// Tails' flying
						FlyingState	= false;
						FlyingTimer = 0;
							
						// Knuckles gliding
						GlidingState = false;
							
						// Reset radiuses to default values
						if !Rolling
						{
							PosY   -= yRadiusDefault - yRadius;
							yRadius = yRadiusDefault; 
							xRadius	= xRadiusDefault;
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
						if Game.ImprovedObjCollision and playerX < objectRight
						{
							exit;
						}
						
						if Xsp < 0
						{
							if Grounded
							{
								Inertia = 0;
								if (!Rolling) Pushing = DirLeft;
							}
							Xsp = 0;
						}
						PosX += objectRight - playerLeft;
					}
						
					// Collide on the left
					else if playerX < objectX
					{	
						if Game.ImprovedObjCollision and playerX > objectLeft
						{
							exit;
						}
						
						if Xsp > 0
						{
							if Grounded
							{
								Inertia = 0;	
								if (!Rolling) Pushing = DirRight;
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