/// @self obj_player
function scr_player_draw()
{
	if player_type == PLAYER.TAILS
	{
	    with obj_tail
	    {
			if player == other.id && sprite_index != -1
			{
				draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, image_yscale, image_angle, draw_colour, image_alpha);
			}
	    }
	}
	
	// Draw using visual_angle instead instead of image_angle to keep the hitbox static
	var _angle = animation == ANIM.MOVE || animation == ANIM.HAMMER_DASH ? visual_angle : 0;
	var _alpha = state == PLAYER_STATE.DEATH ? 1 : image_alpha;
	
	draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, image_yscale, _angle, draw_colour, _alpha);
}