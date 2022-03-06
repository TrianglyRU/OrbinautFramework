/// @function object_is_onscreen(obj)
function object_is_onscreen(obj)
{
	if obj == id
	{
	    // Get sprite radiuses
	    var Width  = sprite_get_width(sprite_index)  div 2;
	    var Height = sprite_get_height(sprite_index) div 2;
	
	    return !(x < Camera.ViewX - Width  or x > Camera.ViewX + global.Width  + Width 
	          or y < Camera.ViewY - Height or y > Camera.ViewY + global.Height + Height);
	}
	else
	{
		if !instance_exists(obj)
	    {
	        return false;
	    }
    
	    // Get sprite radiuses
	    var Width  = sprite_get_width(obj.sprite_index)  div 2;
	    var Height = sprite_get_height(obj.sprite_index) div 2;
	
	    return !(obj.x < Camera.ViewX - Width  or obj.x > Camera.ViewX + global.Width  + Width 
	          or obj.y < Camera.ViewY - Height or obj.y > Camera.ViewY + global.Height + Height);
	}
}