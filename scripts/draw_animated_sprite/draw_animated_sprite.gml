/// @function draw_animated_sprite(sprite,duration,useGlobalTime,x,y)
function draw_animated_sprite(sprite,duration,useGlobalTime,x,y)
{
	// Set duration timer for that sprite
	if !useGlobalTime
	{
		if !ds_map_exists(Game.SpriteTimers, sprite)
		{
			Game.SpriteTimers[? sprite] = 0;
		}
	
		// Count timer
		else if !fade_check(StateActive) and !variable_check(Stage, "IsPaused")
		{
			Game.SpriteTimers[? sprite]++;
		}
		var Timer = Game.SpriteTimers[? sprite];
	}
	else
	{
		var Timer = Game.GlobalTime;
	}
	
	// Draw sprite
	if !duration
	{
		show_debug_message("WARNING: Called draw_animated_sprite with duration equals to 0 or less. Use regular draw_sprite() function!");
	}
	else
	{
		draw_sprite(sprite, Timer div duration mod sprite_get_number(sprite), x, y);
	}
}