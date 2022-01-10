/// @function draw_animated_sprite(spriteid,duration,useGlobalTime,x,y)
function draw_animated_sprite(spriteid,duration,useGlobalTime,x,y)
{
	// Set duration timer for that sprite
	if !useGlobalTime
	{
		if !ds_map_exists(Game.SpriteTimers, spriteid)
		{
			Game.SpriteTimers[? spriteid] = 0;
		}
	
		// Count timer
		else if !fade_check(StateActive) and !variable_check(Stage, "IsPaused")
		{
			Game.SpriteTimers[? spriteid]++;
		}
		var Timer = Game.SpriteTimers[? spriteid];
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
		draw_sprite(spriteid, Timer div duration mod sprite_get_number(spriteid), x, y);
	}
}