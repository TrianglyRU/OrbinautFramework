function StageObjectsSystem()
{
	if Player.Death
	{
		exit;
	}
	
	with all
	{		
		if object_index == BlankObject
		{
			var UnloadX = 32 * InitialRange;
			var UnloadY = 18 * InitialRange;
			
			if !InitialReset
			{	
				var LeftBound   = Screen.CameraX - UnloadX;
				var TopBound    = Screen.CameraY - UnloadY;
				var RightBound  = Screen.CameraX + Screen.Width  + UnloadX;
				var BottomBound = Screen.CameraY + Screen.Height + UnloadY;
				
				if  x >= LeftBound and x <= RightBound
				and y >= TopBound  and y <= BottomBound
				{	
					instance_change(InitialObject, false);
				}
			}
			else if InitialX < Screen.CameraX or InitialX > Screen.CameraX + Screen.Width
			{
				instance_create(InitialX, InitialY, InitialObject);
				instance_destroy(id);
			}		
		}
		else if variable_instance_exists(id, "objLoadRange")
		{	
			var ObjectX = floor(x);
			var ObjectY = floor(y);
			
			var UnloadX = 32 * objLoadRange;
			var UnloadY = 18 * objLoadRange;
			
			var LeftBound   = Screen.CameraX - UnloadX;
			var TopBound    = Screen.CameraY - UnloadY;
			var RightBound  = Screen.CameraX + Screen.Width  + UnloadX;
			var BottomBound = Screen.CameraY + Screen.Height + UnloadY;
			
			if ObjectX < LeftBound or ObjectX > RightBound
			or ObjectY < TopBound  or ObjectY > BottomBound
			{
				var ThisObj = object_index;
				var ThisID  = id;
							
				var  NewObj = instance_create(ObjectX, ObjectY, BlankObject);
				with NewObj
				{
					InitialObject = ThisObj;
					InitialRange  = ThisID.objLoadRange;
					InitialX      = ThisID.objResetX;
					InitialY      = ThisID.objResetY;	
					InitialReset  = ThisID.objResetFlag;
				}				
				instance_destroy(id);
			}
		}	
	}
}