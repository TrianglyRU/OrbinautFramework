if iv_retract
{
    if retract_timer == 0
    {
		retract_offset += 8 * retract_direction;
		
        if abs(retract_offset) >= retract_distance || sign(image_yscale) != sign(retract_offset)
        {
            if sign(image_yscale) >= 0
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
		
		y = ystart;											_visible |= instance_is_drawn();	
		y = ystart + retract_distance * sign(image_yscale); _visible |= instance_is_drawn();
		
		if _visible
		{
			audio_sfx_play(snd_spikes);
		}
    }

    y = ystart + retract_offset;
}

FOR_EACH_PLAYER
{
    var _player = player_get(_p);
    var _type = _player.is_invincible() ? SOLID_TYPE.FULL : SOLID_TYPE.FULL_CLEAR_PLAYER;
    var _hurt_side = image_yscale >= 0 ? SOLID_TOUCH.TOP : SOLID_TOUCH.BOTTOM;
	
	solid_object(_player, _type);
	
	if solid_touch[_p] == _hurt_side
	{
		_player.hurt(id, snd_hurt_spikes);
	}
}