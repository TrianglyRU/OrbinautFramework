/// @function animation_play_sync(spriteid,duration)
function animation_play_sync(spriteid,duration)
{
	if sprite_index != spriteid
	{
		sprite_index = spriteid;
		image_speed  = 0;
	}
	image_index = Renderer.AnimationTime[? GlobalTime] div duration mod image_number;
}