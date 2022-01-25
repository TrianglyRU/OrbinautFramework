/// @function object_check_overlap(collisionType)
function object_check_overlap(collisionType)
{	
	if !Player.AllowCollision
	{
		return false;
	}	
	
	switch collisionType
	{
		case TypeHitbox:
		case TypeHitbox2:
		{	
			// Exit if object can't be overlapped
			if !Obj_HitX or !Obj_HitY
			{
				return false;
			}
			if !object_is_onscreen(id)
			{
				return false;
			}
			
			// Get object's size
			var ObjectTop    = floor(y - Obj_HitY - 0);
			var ObjectLeft   = floor(x - Obj_HitX - 0);
			var ObjectRight  = floor(x + Obj_HitX - 1);
			var ObjectBottom = floor(y + Obj_HitY - 1);
		
			// Get player's normal hitbox
			if !(collisionType == TypeHitbox2 and Player.DoubleSpinAttack)
			{
				var HitboxData = Player.HitboxData[0];
			}
				
			// Get double spin attack hitbox
			else
			{
				var HitboxData = Player.HitboxData[1];
			}
		
			// Check for overlap
			if HitboxData[2] < ObjectLeft or HitboxData[0] > ObjectRight
			{
				return false;
			}
			if HitboxData[3] < ObjectTop or HitboxData[1] > ObjectBottom
			{
				return false;
			}
			return true;
		}
		break;
		case TypeSolidbox:
		{
			// Exit if object can't be overlapped
			if !Obj_SolidX or !Obj_SolidY
			{
				return false;
			}
			if !object_is_onscreen(id)
			{
				return false;
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
			if PlayerBottom < ObjectTop or PlayerTop > ObjectBottom
			{
				return false;
			}
			return true;
		}
		break;
		case TypeTrigger:
		{
			return point_in_rectangle(floor(Player.PosX), floor(Player.PosY), floor(x + Obj_TriggerLeft), floor(y + Obj_TriggerTop), floor(x + Obj_TriggerRight - 1), floor(y + Obj_TriggerBottom - 1));
		}
		break;
	}
}