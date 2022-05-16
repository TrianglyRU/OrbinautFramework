/// @function draw_anisprite(spriteid,duration,useGlobalTime,x,y)
function draw_anisprite(spriteid,duration,useGlobalTime,x,y)
{
	// Define a timer for the sprite
	if !useGlobalTime
	{
		if !ds_map_exists(Renderer.AnimationTime, spriteid)
		{
			ds_map_add(Renderer.AnimationTime, spriteid, 0);
		}
		else if Renderer.UpdateAnimations
		{
			Renderer.AnimationTime[? spriteid]++;
		}
		var Timer = Renderer.AnimationTime[? spriteid];
	}
	else
	{
		var Timer = Renderer.AnimationTime[? GlobalTime];
	}
	
	// Draw it
	if !duration
	{
		show_debug_message("WARNING: draw_anisprite function called with duration equal 0 or less. Use regular draw_sprite function!");
	}
	else
	{
		draw_sprite(spriteid, Timer div duration mod sprite_get_number(spriteid), x, y);
	}
}