/// @function object_set_hitbox(xradius, yradius)
function object_set_hitbox(xradius, yradius)
{	
	// Report script error if instance is not set as an object
	if !variable_instance_exists(id, "IsStageObject")
	{
		show_message("Instance ID " + string(id) + " (" + string(object_get_name(self)) + ") is not initialized as object. Please, call function 'object_setup' in the Create or Room Start event");
		game_end();
	}
	
	// Get object centre
	var xCentre = sprite_get_width(sprite_index)  / 2;
	var yCentre = sprite_get_height(sprite_index) / 2;
	
	// Get object current hotspot
	var xOffset = sprite_get_xoffset(sprite_index);
	var yOffset = sprite_get_yoffset(sprite_index);
	
	// Set sprite hotspot im the centre if it is not, and adjust object position
	if xOffset != xCentre or yOffset != yCentre
	{
		sprite_set_offset(sprite_index, sprite_width / 2, sprite_height / 2);
		x += xCentre - xOffset;
		y += yCentre - yOffset;
	}
	
	// Set our hitbox
	sprite_set_bbox_mode(sprite_index, bboxmode_manual);
	sprite_set_bbox(sprite_index, xCentre - xradius, yCentre - yradius, xCentre * 2 - (xCentre - xradius + 1), yCentre * 2 - (yCentre - yradius + 1));
}