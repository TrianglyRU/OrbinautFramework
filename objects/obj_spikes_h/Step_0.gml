if iv_retract
{
    if retract_timer == 0
    {
		retract_offset += 8 * retract_direction;
		
        if abs(retract_offset) >= retract_distance || sign(image_xscale) != sign(retract_offset)
        {
            if sign(image_xscale) >= 0
            {
                retract_offset = clamp(retract_offset, 0, retract_distance);
            }
            else
            {
                retract_offset = clamp(retract_offset, -retract_distance, 0);
            }

            retract_timer = 60;
            retract_direction *= -1;
        }
    }
    else if --retract_timer == 0
    {
		var _visible = false;
		
		x = xstart;											_visible |= instance_is_drawn();	
		x = xstart + retract_distance * sign(image_xscale); _visible |= instance_is_drawn();
		
		if _visible
		{
			audio_sfx_play(snd_spikes);
		}
    }

    x = xstart + retract_offset;
}

FOR_EACH_PLAYER
{
    var _player = player_get(_p);
    var _hurt_side = image_xscale >= 0 ? SOLID_TOUCH.LEFT : SOLID_TOUCH.RIGHT;
	
	solid_object(_player, SOLID_TYPE.FULL);
	
	if solid_touch[_p] == _hurt_side
	{
		_player.hurt(id, snd_hurt_spikes);
	}
}