/// @function draw_animated_sprite_reset(sprite)
function draw_animated_sprite_reset(sprite)
{
	// Reset animation timer for that sprite
	if ds_map_exists(Game.SpriteTimers, sprite)
	{
		Game.SpriteTimers[? sprite] = 0;
	}
}