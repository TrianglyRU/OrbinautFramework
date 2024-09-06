/// @function scr_player_draw
function scr_player_draw()
{
	gml_pragma("forceinline");
	
	// Draw Tails' tails
	if PlayerType == PLAYER_TAILS
	{
	    var _tails = noone;
		
	    // Find the tails object associated with this player
	    with obj_tail if TargetPlayer == other.id
	    {
	        _tails = id;
	    }

	    if _tails != noone
	    {
	        var _x = floor(x + _tails.tail_offset_x * _tails.image_xscale);
	        var _y = floor(y + _tails.tail_offset_y * _tails.image_yscale);
        
	        // Draw the tails sprite
	        draw_sprite_ext(_tails.sprite_index, _tails.image_index, _x, _y, _tails.image_xscale, _tails.image_yscale, _tails.image_angle, c_white, 1.0);
	    }
	}
	
	if state == PLAYER_STATE_DEATH
	{
		image_alpha = 1.0;
	}
	
	// Inherit the parent event
	event_inherited();
}