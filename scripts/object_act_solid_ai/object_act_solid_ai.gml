/// @function object_act_solid_ai(collideSides, collideTop, collideBottom, collisionMap)
function object_act_solid_ai(collideSides, collideTop, collideBottom, collisionMap)
{
	// Exit if there is no AI in the stage
	if (!instance_exists(AI)) exit;
	
	// Exit the code if no solid radiuses were initialized for this object
	if (!variable_instance_exists(id, "objXRadiusSolid")) exit;

	// Exit the code if there is no side to collide with 
	if (!collideSides and !collideTop and !collideBottom) exit;
	
	// Get object properties
	var objectX		   = floor(x);
	var objectY        = floor(y);
	var objectTop      = floor(y - objYRadiusSolid - 1);
	var objectLeft     = floor(x - objXRadiusSolid);
	var objectRight    = floor(x + objXRadiusSolid - 1);
	var objectBottom   = floor(y + objYRadiusSolid);	
	var objectMirrored = !image_xscale;
	var objectFlipped  = !image_yscale;
	var objectType	   = !collideSides and !collideBottom ? "isPlatform" : "isRegular";

	// Get player properties
	var playerX      = floor(AI.PosX);
	var playerY      = floor(AI.PosY);
	var playerTop    = floor(AI.PosY - AI.yRadius);
	var playerLeft   = floor(AI.PosX - 11);
	var playerRight  = floor(AI.PosX + 11);
	var playerBottom = floor(AI.PosY + AI.yRadius);
	
	// Check if player is standing on this object, and collide only with its top side
	if AI.OnObject == id
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
			else if playerPosition > objXRadiusSolid * 2
			{
				objectTop = objectY - collisionMap[objXRadiusSolid * 2];
			}
			else
			{
				objectTop = objectY - collisionMap[playerPosition];
			}
			
			// Correct it
			objectTop -= 1;
		}
			
		// Reset balancing flag
		AI.Balancing = false;
		
		// Check if player should start balancing
		if AI.Inertia == 0
		{
			if playerX <= objectLeft  + 4 and AI.Facing == DirLeft
			or playerX >= objectRight - 4 and AI.Facing == DirRight
			{
				AI.Balancing = DirRight;
			}
			if playerX <= objectLeft  + 4 and AI.Facing == DirRight
			or playerX >= objectRight - 4 and AI.Facing == DirLeft
			{
				AI.Balancing = DirLeft;
			}
		}
					
		// Extend object collision diameter if left and right sides are solid
		var edgeExtension = collideSides ? 10 : 0;
					
		// Check if player is outside of this object collision diameter
		if playerX + edgeExtension < objectLeft or playerX - edgeExtension > objectRight or !collideTop
		{
			AI.OnObject = false;
			exit;
		}
		
		// Make player to follow horizonatal movement of the object
		AI.PosX += floor(x - xprevious);
							
		// Make player to always stay on top of the object
		AI.PosY = objectTop - AI.yRadius;
	}
			
	// If player is not standing on this object, collide with it
	else
	{
		// Check type of this object
		if objectType = "isRegular" 
		{
			// Check for overlap with this object horizontally
			if (playerRight < objectLeft or playerLeft > objectRight) exit;

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
					objectTop = objectY - objYRadiusSolid - 1;
				}
			}
					
			// Check for overlap with this object vertically
			if playerBottom < objectTop - 4 or playerTop > objectBottom
			{
				exit;
			}
					
			// Collide with this object vertically
			if abs(objectX - playerX) + 4 <= abs(objectY - playerY) - 4
			{
				// Check if bottom side is solid
				if collideBottom
				{
					// Check if player is below this object
					if playerY > objectY and playerTop < objectBottom
					{
						// If player is grounded, kill them
						if AI.Grounded
						{
							object_damage(false, false, true);
						}

						// Else push player out from this object
						else if AI.Ysp < 0
						{
							AI.PosY = objectBottom + AI.yRadius;
							AI.Ysp  = 0;
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
						if playerX < objectLeft or playerX > objectRight
						{
							exit;
						}
						else with AI
						{
							// Check if player is moving downwards or standing still
							if (Ysp < 0) exit;
						
							// If player is airborne, let him land on this object	
							if !Grounded
							{
								Grounded = true;
								AIResetOnFloor();
							}

							// Set speed and angle
							Inertia  = Xsp;
							Angle    = 360;		
							Ysp      = 0;
									
							// Attach player to the object's top boundary
							PosY = objectTop - yRadius;
						}
						
						// Tell player we're standing on this object
						AI.OnObject = id;
					}	
				}
			}
			
			// Collide with this object horizontally
			else
			{
				if collideSides
				{
					// Collide on the right
					if floor(AI.PosX) > x
					{
						if AI.Xsp < 0
						{
							if AI.Grounded
							{
								AI.Inertia = 0;
								if (!AI.Rolling) AI.Pushing = DirLeft;
							}
							AI.Xsp = 0;
						}
						AI.PosX += objectRight - playerLeft;
					}
						
					// Collide on the left
					if floor(AI.PosX) < x
					{	
						if AI.Xsp > 0
						{
							if AI.Grounded
							{
								AI.Inertia = 0;	
								if (!AI.Rolling) AI.Pushing = DirRight;
							}
							AI.Xsp = 0;
						}
						AI.PosX -= playerRight - objectLeft;
					}
				}
			}
		}

		// Check if the only solid side is top (platform object)
		if objectType = "isPlatform"
		{
			// Check if player is moving downwards or standing still
			if (AI.Ysp < 0) exit;
		
			// Check if player's position is within this object boundaries
			if (playerX < objectLeft or playerX > objectRight) exit;
		
			// If collisionMap is assigned, define new top or bottom boundary
			if collisionMap != false and !objectFlipped
			{
				// Get player position within the object
				var playerPosition = objectMirrored ? objectRight - playerX : playerX - objectLeft;
				
				// Define new object actual height based on current player position
				if playerPosition < 0
				{
					objectTop = objectY - collisionMap[0];
				}
				else if playerPosition > objXRadiusSolid * 2
				{
					objectTop = objectY - collisionMap[objXRadiusSolid * 2];
				}
				else
				{
					objectTop = objectY - collisionMap[playerPosition];
				}
			
				// Correct it
				objectTop -= 1;
			}
					
			// Check if player's bottom has overlapped this object's top boundary
			if playerBottom < objectTop - 4 or playerBottom >= objectTop + 16
			{
				exit;
			}
			else with AI
			{
				// If player is airborne, let him land on this object	
				if !Grounded
				{
					Grounded = true;
					AIResetOnFloor();
				}
					
				// Set speed and angle
				Inertia  = Xsp;
				Angle    = 360;		
				Ysp      = 0;
					
				// Attach player to the object's top boundary
				PosY = objectTop - yRadius;
			}
			
			// Tell player we're standing on this object
			AI.OnObject = id;
		}
	}
}