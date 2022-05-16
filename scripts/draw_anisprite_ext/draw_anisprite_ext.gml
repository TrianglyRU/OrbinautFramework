/// @function draw_anisprite_ext(spriteid,duration,useGlobalTime,x,y,xscale,yscale)
function draw_anisprite_ext(spriteid,duration,useGlobalTime,x,y,xscale,yscale)
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
		draw_sprite_ext(spriteid, Timer div duration mod sprite_get_number(spriteid), x, y, xscale, yscale, 0, c_white, 1);
	}
}