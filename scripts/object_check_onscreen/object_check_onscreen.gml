/// @function object_is_onscreen(obj)
function object_is_onscreen(obj)
{
	if !instance_exists(obj)
	{
		return false;
	}
	
	// Get sprite radiuses
	var Width  = sprite_get_width(obj.sprite_index)  div 2;
	var Height = sprite_get_height(obj.sprite_index) div 2; 
	
	return obj.x >= Camera.ViewX - Width  and obj.x <= Camera.ViewX + Game.Width  + Width 
	   and obj.y >= Camera.ViewY - Height and obj.y <= Camera.ViewY + Game.Height + Height;
}