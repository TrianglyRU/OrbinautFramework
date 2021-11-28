/// @function object_check_overlap(collisionType)
function object_check_overlap(collisionType)
{	
	// Exit if collision is disabled
	if !Player.AllowCollision
	{
		return false;
	}	
	else switch collisionType
	{
		case TypeHitbox:
		case TypeHitbox2:
		{
			// Exit if this object hitbox isn't initialised
			if !variable_instance_exists(id, "Obj_HitStatus")
			{
				return false;
			}
		
			// Exit if object can't be overlapped
			if !Obj_HitX or !Obj_HitY
			{
				return false;
			}
		
			// Exit if object is off-screen
			if !object_is_onscreen(id)
			{
				return false;
			}
			
			// Get object's size
			var ObjectTop    = floor(y - Obj_HitY - 0);
			var ObjectLeft   = floor(x - Obj_HitX - 0);
			var ObjectRight  = floor(x + Obj_HitX - 1);
			var ObjectBottom = floor(y + Obj_HitY - 1);
		
			// Get player's hitbox
			if Game.Character != CharTails and Player.Animation == AnimCrouch and Player.image_index + 1 == Player.image_number
			{
				var PlayerTop    = floor(Player.PosY - 4);
				var PlayerLeft   = floor(Player.PosX - 8);
				var PlayerRight  = floor(Player.PosX + 8);
				var PlayerBottom = floor(Player.PosY + 16);		
			}
			else
			{
				if collisionType == TypeHitbox2 and Player.DoubleSpinAttack
				{
					var PlayerTop    = floor(Player.PosY - 24);
					var PlayerLeft   = floor(Player.PosX - 24);
					var PlayerRight  = floor(Player.PosX + 24);
					var PlayerBottom = floor(Player.PosY + 24);
				}
				else
				{
					var PlayerTop    = floor(Player.PosY - Player.RadiusY + 3);
					var PlayerLeft   = floor(Player.PosX - 8);
					var PlayerRight  = floor(Player.PosX + 8);
					var PlayerBottom = floor(Player.PosY + Player.RadiusY - 3);
				}
			}
		
			// Check for overlap
			if PlayerRight < ObjectLeft or PlayerLeft > ObjectRight
			{
				return false;
			}
			else if PlayerBottom < ObjectTop or PlayerTop > ObjectBottom
			{
				return false;
			}
		
			// If player overlaps object on both axis, they collided with it
			return true;
		}
		break;
		case TypeSolidbox:
		{
			// Exit if this object solidbox isn't initialised
			if !variable_instance_exists(id, "Obj_SolidStatus")
			{
				return false;
			}
		
			// Exit if object can't be overlapped
			if !Obj_SolidX or !Obj_SolidY
			{
				return false;
			}
		
			// Exit if object is off-screen
			if !object_is_onscreen(id)
			{
				exit;
			}
		
			// Get object's size
			var ObjectTop    = floor(y - Obj_SolidY - 0);
			var ObjectLeft   = floor(x - Obj_SolidX - 0);
			var ObjectRight  = floor(x + Obj_SolidX - 1);
			var ObjectBottom = floor(y + Obj_SolidY - 1);
		
			// Get player's solidbox
			var PlayerTop    = floor(Player.PosY - Player.RadiusY);
			var PlayerLeft   = floor(Player.PosX - Player.RadiusX);
			var PlayerRight  = floor(Player.PosX + Player.RadiusX);
			var PlayerBottom = floor(Player.PosY + Player.RadiusY);
		
			// Check for overlap
			if PlayerRight < ObjectLeft or PlayerLeft > ObjectRight
			{
				return false;
			}
			else if PlayerBottom < ObjectTop or PlayerTop > ObjectBottom
			{
				return false;
			}
		
			// If player overlaps object on both axis, they collided with it
			return true;
		}
		break;
		case TypeTrigger:
		{
			// Exit if this object triggerbox isn't initialised
			if !variable_instance_exists(id, "Obj_TriggerStatus")
			{
				return false;
			}
		
			// Return check result
			return point_in_rectangle(floor(Player.PosX), floor(Player.PosY), floor(x + Obj_TriggerLeft), floor(y + Obj_TriggerTop), floor(x + Obj_TriggerRight - 1), floor(y + Obj_TriggerBottom - 1));
		}
		break;
	}
}