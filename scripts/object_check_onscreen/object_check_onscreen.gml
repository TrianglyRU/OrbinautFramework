/// @function object_is_onscreen(obj)
function object_is_onscreen(obj)
{
	// Return false if object does not exist
	if !instance_exists(obj)
	{
		return false;
	}
	
	// Get radiuses
	var Width  = sprite_get_width(obj.sprite_index)  div 2;
	var Height = sprite_get_height(obj.sprite_index) div 2; 
	
	// Return
	return obj.x >= Camera.ViewX - Width  and obj.x <= Camera.ViewX + Game.Width  + Width 
	   and obj.y >= Camera.ViewY - Height and obj.y <= Camera.ViewY + Game.Height + Height;
}