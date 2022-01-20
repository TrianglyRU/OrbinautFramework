/// @function animation_play_sync(spriteid,duration)
function animation_play_sync(spriteid,duration)
{
	// Update sprite
	if sprite_index != spriteid
	{
		sprite_index = spriteid;
		image_speed  = 0;
	}
	
	// Play animation
	image_index = Game.AnimationTime[? GlobalTime] div duration mod image_number;
}