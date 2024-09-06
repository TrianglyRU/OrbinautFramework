// Handle spike movement
if MoveSpikes
{
    // Manage retraction timing
    if retract_timer > 0 
    {
        if --retract_timer == 0 && obj_is_visible()
        {
            audio_play_sfx(sfx_spikes_move);
        }
    }
    else
    {
        retract_offset += 8 * retract_direction;

        // Handle retraction limits and direction reversal
        if abs(retract_offset) >= retract_distance || sign(image_xscale) != sign(retract_offset)
        {
            if image_xscale > 0
            {
                retract_offset = clamp(retract_offset, 0, retract_distance);
            }
            else if image_xscale < 0
            {
                retract_offset = clamp(retract_offset, -retract_distance, 0);
            }

            retract_timer = 60;
            retract_direction *= -1;
        }
    }

    x = xstart + retract_offset;
}

// Check player collision with spikes and apply damage
for (var p = 0; p < PLAYER_COUNT; p++)
{
    var _player = player_get(p);
    var _collision_side = image_xscale >= 0 ? SOLIDCOLLISION.LEFT : SOLIDCOLLISION.RIGHT;

    obj_act_solid(_player, SOLIDOBJECT.FULL);
	
	if obj_check_solid(_player, _collision_side)
    {
        _player.m_player_hurt(sfx_spikes_hurt);
    }
}